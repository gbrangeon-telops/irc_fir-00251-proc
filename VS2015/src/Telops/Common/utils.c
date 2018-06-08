/**
 *  @file utils.c
 *  Usefull functions for the FPGA
 *
 *  Defines usefull functions to utilise in the project
 *
 *  $Rev: 21389 $
 *  $Author: odionne $
 *  $LastChangedDate: 2018-02-05 16:37:07 -0500 (Mon, 05 Feb 2018) $
 *  $Id: utils.c 21389 2018-02-05 21:37:07Z odionne $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Common/trunk/Software/utils.c $
 *  1.00x dha   04/06/18 ***Heavily modified to compile independant of firmware.***
 */

//#include <systemc.h> // For sc_time_stamp().value()
#include <stdarg.h> // To support ... argument in sim_printf
 //#include <iostream.h>
 //#include <iomanip>
#include <math.h>
#include <float.h>
#include <cfloat>

#include "utils.h"
#include "printf_utils.h"
#include "verbose.h"

#define XPAR_CPU_CORE_CLOCK_FREQ_HZ 100000000

uint32_t bitget(uint32_t value, uint8_t bitposition)
{
//   uint32_t mask  = (uint32_t)1 << bitposition;

//   return ((value & mask) >> bitposition);

   return (value & ( 1 << bitposition )) >> bitposition;
}

/**
 *  elapsed_time_us.
 *  Use this function compute the time elapsed from a starting time in us.
 *
 *  @param tic Starting time in ticks
 *
 *  @return Elapsed time in us
 */
uint64_t elapsed_time_us(uint64_t tic)
{
   uint64_t etime_ticks;   // Elapsed time in ticks count.
   uint64_t etime_us;      // Elapsed time in us.
   uint64_t toc;           // Number of ticks at this time.

   // Get the number ticks at this time
   GETTIME(&toc); 

   // Compute the elapsed time in ticks count
    etime_ticks = toc - tic;

	// Translate elapsed time in us
   etime_us = etime_ticks * TIME_ONE_SECOND_US / XPAR_CPU_CORE_CLOCK_FREQ_HZ;

   // JRO : This verification is added because sometime in simulation the counter restart for no reason
   if((toc-tic) >= (uint64_t)2147483647) // 2^31 : ~10s at 200Mhz
      return 0;

   return etime_us;
}

void WriteStruct(const void* pStruct)
{
	//Not Implemented;
}


//---------------------------------------------------------------------------
// Returns the value rounded to the given multiple (quantity).
//
// Parameters
// -----------
// value    Value to round.
// quantity Quantity to multiply by an integer to obtain the multiple.
//
// Return
// -----------
// The value rounded to the given multiple (quantity).
//---------------------------------------------------------------------------
float roundMultiple( float value, float quantity )
{
   return ( roundf( value / quantity ) * quantity );
}

//---------------------------------------------------------------------------
// Returns the largest multiple of a given quantity that is not greater than
// the given value.
//
// Parameters
// -----------
// value    Value to round.
// quantity Quantity to multiply by an integer to obtain the multiple.
//
// Return
// -----------
// The largest multiple that is not greater than the given value.
//---------------------------------------------------------------------------
float floorMultiple( float value, float quantity )
{
   return ( floorf( value / quantity ) * quantity );
}

//---------------------------------------------------------------------------
// Returns the smallest multiple of a given quantity that is not less than
// the given value.
//
// Parameters
// -----------
// value    Value to round.
// quantity Quantity to multiply by an integer to obtain the multiple.
//
// Return
// -----------
// The smallest multiple that is not less than the given value.
//---------------------------------------------------------------------------
float ceilMultiple( float value, float quantity )
{
   return ( ceilf( value / quantity ) * quantity );
}


#ifdef SIM
// The following code is to support printing to the console during SystemC debug
// but also to send stdout to the UART (with outbyte)

extern void outbyte (char);

/**
 *  sim_print.
 *  Display a string in a console for SystemC simulation.
 *  
 *  @param str String to display
 *  
 *  @return Void
 */
void sim_print(char *str)
{
   unsigned long now_us;
   unsigned long now_ns;
   now_us = (unsigned long)(sc_time_stamp().value()/1000000);
   now_ns = (unsigned long)(sc_time_stamp().value()/1000) - now_us*1000;

   cout << now_us << "." << now_ns << " us: " << str;

   // Uncomment the following lines to send to UART during simulation
   //   while (*str)
   //   {
   //      outbyte (*str++);
   //   }
}

/**
 *  sim_printf.
 *  Display a formatted string in a console for SystemC simulation.
 *  
 *  @param format string that contains the text to be displays with format specifiers
 *  @param ... Additionnal arguments depending on the format string
 *  
 *  @return Void
 */
void sim_printf(const char *format, ...)
{
   char str[1000];
   unsigned long now_us;
   unsigned long now_ns;

   now_us = (unsigned long)(sc_time_stamp().value()/1000000);
   now_ns = (unsigned long)(sc_time_stamp().value()/1000) - now_us*1000;

   // The va stuff is from stdarg.h
   va_list ap;
   va_start(ap, format);

   // Format the string using vsprintf
   vsprintf(str, format, ap);

   // Then send it to SystemC console
   cout << now_us << "." << now_ns << " us: " << str;

   // Clean up the argument list to be able to use it again
   va_end(ap);
   va_start(ap, format);

   // Use vprintf to print to stdout (UART)
   //vprintf(format, ap);
}

#endif

/**
 * Perform a memory copy. This version allows data bytes swapping.
 *
 * @param dst is the pointer to the destination memory.
 * @param src is the pointer to the source memory.
 * @param length is the amount of data to copy in bytes.
 * @param dataSize is the size of individual data elements in bytes
 *        (1 for char/uint8/int8, 2 for uint16/int16 and 4 for uint32/int32).
 * @param swap indicates whether the data bytes must be swapped.
 *
 * @return a pointer to destination data.
 */
void *memcpy_swap(void *dst, const void *src, size_t length, uint8_t dataSize, uint8_t swap)
{
   uint8_t *p_src = (uint8_t *)src;
   uint8_t *p_dst = (uint8_t *)dst;

   if (swap)
   {
      if  ((length % dataSize) == 0)
      {
         while (length > 0)
         {
            length--;

            *(p_dst + (length % dataSize)) = *p_src++;

            if  ((length % dataSize) == 0)
            {
               p_dst += dataSize;
            }
         }
      }
   }
   else
   {
      while (length > 0)
      {
         length--;

         *p_dst++ = *p_src++;
      }
   }

   return dst;
}

/**
 * Print memory data.
 *
 * @param buffer is the pointer to the memory buffer to print.
 * @param length is the amount of data to print in bytes.
 * @param baseAddr is the address corresponding to the first buffer byte.
 * @param lineSize is the number of bytes to print on a single line.
 */
void memdump(const void *buffer, size_t length, uint32_t baseAddr, uint32_t lineSize)
{
#ifdef ENABLE_PRINTF
   uint8_t *p_buffer = (uint8_t *)buffer;
   uint32_t i;

   for (i = 0; i < length; i++)
   {
     if ( i % lineSize == 0)
     {
       PRINTF("0x%08X: 0x", baseAddr + i);
     }

     PRINTF("%02X", p_buffer[i]);

     if ( i % lineSize == lineSize - 1)
     {
       PRINTF("\n");
     }
     else
     {
       PRINTF(" ");
     }
   }

   if (length % lineSize != 0)
   {
      PRINTF("\n");
   }
#endif
}

/**
 * Convert hex digit to its numerical value.
 *
 * @param x is the hex digit to convert.
 *
 * @return The value corresponding to the hex digit.
 * @return 0 if the specified char is not an hex digit.
 */
uint8_t Hex2Val(const char x)
{
   uint8_t val = 0;

   if ((x >= '0') && (x <= '9'))
   {
      val = (uint8_t)(x - '0');
   }
   else if ((x >= 'A') && (x <= 'F'))
   {
      val = ((uint8_t)(x - 'A')) + 10;
   }
   else if ((x >= 'a') && (x <= 'f'))
   {
      val = ((uint8_t)(x - 'a')) + 10;
   }

   return val;
}

/**
 * Convert two hex digits to its a byte value.
 *
 * @param buffer is char buffer containing the hex digits to convert.
 *
 * @return The byte value corresponding to the hex digits.
 */
uint8_t Hex2Byte(const char *buffer)
{
   return ((Hex2Val(buffer[0]) << 4) + Hex2Val(buffer[1]));
}

/**
 * Convert (2 * N) hex digits to their N bytes value.
 *
 * @param buffer is a char buffer containing the hex digits to convert.
 * @param buflen is the char buffer length.
 * @param bytebuffer is the byte buffer where the converted bytes will be written.
 * @param bytebuflen is the byte buffer length.
 *
 * @return The number of bytes written in byte buffer.
 */
uint32_t Hex2Bytes(const char *buffer, uint32_t buflen, uint8_t *bytebuffer, uint32_t bytebuflen)
{
   uint32_t i;
   uint32_t byteCount = 0;

   for (i = 0; ((i < buflen) && (byteCount < bytebuflen)); i += 2)
   {
      bytebuffer[byteCount++] = Hex2Byte(&buffer[i]);
   }

   return byteCount;
}

/**
 * Mathematically correct implementation of a modulus operator.
 *
 * performs y = a mod b
 *            = a - n.*b where n = floor(a./b) if b ~= 0
 *
 * the C '%' operator is actually a remainder operation, which has the same
 * result when a and b have the same sign
 *
 * @param a is an integer.
 * @param b is an integer
 *
 * @return The number of bytes written in byte buffer.
 */
int mod(int a, int b) {
   return ((a % b) + b) % b;
}

/**
 * Round an integer value to the next multiple.
 *
 * @param x is the integer
 * @param m is the multiple
 *
 * @return Next multiple.
 */
uint32_t roundUp(uint32_t x, uint32_t m)
{
   if (m == 0)
      return x;

   if (x == 0)
      return 0;

   return ((((x - 1) / m) + 1) * m);
}

/**
 * Round an integer value to the previous multiple.
 *
 * @param x is the integer
 * @param m is the multiple
 *
 * @return Previous multiple.
 */
uint32_t roundDown(uint32_t x, uint32_t m)
{
   if (m == 0)
      return x;

   return x - (x % m);
}

void resetStats(statistics_t* s)
{
   if (s != 0)
   {
      s->N = 0;
      s->max = FLT_MIN;
      s->min = FLT_MAX;
      s->mu = 0;
      s->R = 0;
      s->var = -1; // invalid result for N < 2
   }
}

void updateStats(statistics_t* s, float x)
{
   if (s != 0)
   {
      float N = (float) (++s->N);
      float tmp = x - s->mu;

      s->mu += tmp/N;

      s->R += tmp * (x - s->mu);

      if (x > s->max)
         s->max = x;

      if (x < s->min)
         s->min = x;

      if (N > 1)
         s->var = s->R/(N-1);
   }
}

void reportStats(statistics_t* s, char* label)
{
#ifdef ENABLE_PRINTF
   char defaultLabel[12] = "Untitled";
   char* str;

   if (label == 0)
      str = defaultLabel;
   else
      str = label;

   PRINTF("Statistics report for %s\n", str);
   PRINTF("Number of samples %d\n", s->N);
   PRINTF("Min value :" _PCF(3) "\n", _FFMT(s->min, 3));
   PRINTF("Max value :" _PCF(3) "\n", _FFMT(s->max, 3));
   PRINTF("Average :" _PCF(3) "\n", _FFMT(s->mu, 3));
   PRINTF("Std :" _PCF(3) "\n", _FFMT(sqrtf(s->var), 3));
#endif
}

int gcd(int x, int y)
{
   int a, b;
   int r;

   a = x;
   b = y;

   r = a % b;
   while(r)
   {
      a = b;
      b = r;
      r = a % b;
   }

   return b;
}

int lcm(int x, int y)
{
   return x * (y/gcd(x,y));
}

uint32_t select(uint32_t* list, int left, int right, int n)
{
     while (1)
     {
         if (left == right)
             return list[left];

         int pivotIndex = (left + right)/2; // select pivotIndex between left and right
         pivotIndex = partition(list, left, right, pivotIndex);
         if (n == pivotIndex)
             return list[n];
         else if (n < pivotIndex)
             right = pivotIndex - 1;
         else
             left = pivotIndex + 1;
     }
}

int partition(uint32_t* list, int left, int right, int pivotIndex)
{
   int i;
   int pivotValue = list[pivotIndex];
   uint32_t tmp;
   int storeIndex = left;

   tmp = list[right];
   list[right] = list[pivotIndex]; // Move pivot to end
   list[pivotIndex] = tmp;

   for (i=left; i<right; ++i)
   {
      if (list[i] < pivotValue)
      {
         tmp = list[i];
         list[i] = list[storeIndex];
         list[storeIndex] = tmp;
         ++storeIndex;
      }
   }
   tmp = list[right];
   list[right] = list[storeIndex]; // Move pivot to its final place
   list[storeIndex] = tmp;

   return storeIndex;
}

/**
 * utility funtion used by invnormcdf()
 * (Abramowitz & Stegun, Handbook of Mathematical Functions with Formulas, Graphs, and Mathematical Tables, 1964)
 * approximation coefficients from Paul M. Voutier, A New Approximation to the Normal Distribution Quantile Function, 2010
 *
 * @param t the value at which to approximate the function
 *
 * @return the approximated value.
 */
double AS_rationalapprox(double t)
{
   const double c[3] = {2.653962002601684482, 1.561533700212080345, 0.061146735765196993};
   const double d[3] = {1.904875182836498708, 0.454055536444233510, 0.009547745327068945};

   t = t - ((c[2]*t + c[1])*t + c[0]) /
         (((d[2]*t + d[1])*t + d[0])*t + 1.0);

   return t;
}
double invnormcdf(double p)
{
   double xp;

   if (p<=0)
      return -DBL_MAX;

   if (p>=1)
      return DBL_MAX;

   if (p < 0.5)
      xp = -AS_rationalapprox(sqrt(-2.0*log(p)));
   else
      xp = AS_rationalapprox(sqrt(-2.0*log(1.0-p)));

   return xp;
}

/**
 * Convert a decimal number to a binary string.
 * @warning Truncation is done by keeping the lsb (sign may be lost).
 *
 * @param decimal Number to convert.
 * @param nbBit Number of char to write (max = NB_BIT_MAX).
 *
 * @return Pointer to result string.
 */
char *dec2bin(const int decimal, uint8_t nbBit)
{
#define NB_BIT_MAX 32

   // Declare str as static to be returnable
   static char str[NB_BIT_MAX + 1];
   uint8_t n;

   if (nbBit > NB_BIT_MAX)
   {
      // Return empty string
      str[0] = '\0';
      FPGA_PRINT("Error dec2bin: nbBit > NB_BIT_MAX");
   }
   else
   {
      // Write string with msb as 1st char
      for (n = 0; n < nbBit; n++)
         str[nbBit - n - 1] = (decimal & (1 << n)) ? '1' : '0';
      // Terminate string
      str[nbBit] = '\0';
   }

   return str;
}

int32_t medianOf3(const int32_t a[3])
{
   /*
     table de vérité pour les 6 combinaisons de 3 éléments
        m
     0, 1, 2
     0, 2, 1
     1, 0, 2
     1, 2, 0
     2, 0, 1
     2, 1, 0
    */

   int32_t m;

   m = a[1]; // initial assignment to save one comparison
   if (a[0] < a[1])
   {
      if (a[2] < a[0])
         m = a[0];
      else if (a[2] < a[1])
         m = a[2];
   }
   else
   {
      if (a[0] < a[2])
         m = a[0];
      else if (a[1] < a[2])
         m = a[2];
   }

   return m;
}

/**
 * Initialize the process context.
 *
 * @param ctxt Pointer to the context instance.
 * @param i0 First index used by the context block.
 * @param totalLength Total context length.
 * @param blockLength Context block length.
 *
 * @return void.
 */
void ctxtInit(context_t* ctxt, uint32_t i0, uint32_t totalLength, uint32_t blockLength)
{
   ctxt->startIndex = i0;
   ctxt->totalLength = totalLength;
   ctxt->blockIdx = 0;
   ctxt->blockLength = blockLength;
}

/**
 * Execute an iteration (block) of the process context.
 *
 * @param ctxt Pointer to the context instance.
 *
 * @return Context block length.
 */
uint32_t ctxtIterate(context_t* ctxt)
{
   ctxt->startIndex = MIN(ctxt->startIndex + ctxt->blockLength, ctxt->totalLength);

   ctxt->blockLength = MIN(ctxt->totalLength - ctxt->startIndex, ctxt->blockLength);
   ++ctxt->blockIdx;

   return ctxt->blockLength;
}

/**
 * Indicates whether the process context is done.
 *
 * @param ctxt Pointer to the context instance.
 *
 * @return True if context is done.
 * @return False if context is not done.
 */
bool ctxtIsDone(const context_t* ctxt)
{
   return ctxt->blockLength == 0;
}
