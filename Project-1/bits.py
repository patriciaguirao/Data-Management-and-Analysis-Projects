# Part 1 goes here!

# Custom Exception
# DecodeError - raised when there's an issue attempting to decode a series of bits as a particular encoding
class DecodeError(Exception):
    pass


# Custom Exception
# ChunkError - raised when a series of bits can be split up into evenly sized chunks of bits
class ChunkError(Exception):
    pass


# this is the main class for BitList
class BitList:

    def __init__(self, bits_string):
        all_binary = all(char in '01' for char in bits_string)
        if (all_binary != True):
            raise ValueError('Format is invalid; does not consist of only 0 and 1')
        self.bits = bits_string


    @staticmethod
    def from_ints(*numbers):
        bool = all(i in [0, 1] for i in numbers)
        if(bool != True):
            raise ValueError('Format is invalid; does not consist of only 0 and 1')
        strBits = ''.join(map(str,numbers))
        return BitList(strBits)

    def __str__(self):
        return self.bits

    def __eq__(self, other):
        return self.bits == other.bits

    def arithmetic_shift_left(self):
        self.bits = self.bits[1:] + '0'

    def arithmetic_shift_right(self):
        self.bits = self.bits[0:1] + self.bits[:len(self.bits)-1]

    def bitwise_and(self, otherBitList):
        new_bit_list = ''
        for i in range(0, len(self.bits)):
            if self.bits[i] == otherBitList.bits[i] == '1':
                new_bit_list += '1'
            else:
                new_bit_list += '0'
        newBitList = BitList(new_bit_list)
        return newBitList

    def chunk(self, chunk_length):
      if len(self.bits) % chunk_length != 0:
          raise ChunkError('Bitlist cannot be broken up into even chunks of this chunk length')
      chunks = [self.bits[i:i+chunk_length] for i in range(0, len(self.bits), chunk_length)]
      for i in range(len(chunks)):
          chunks[i] = list(chunks[i])
          chunks[i] = [int(bit) for bit in chunks[i]]
      return chunks

    def decode(self, encoding='utf-8'):
      if(encoding != 'utf-8' and encoding != 'us-ascii'):
        raise ValueError('The encoding is not supported')
      decodeStr = ''
      if(encoding == 'us-ascii'):
          newBlStr = self.bits
          if(len(self.bits) % 7 != 0):
              newBlStr = '0'*(len(self.bits) % 7) + self.bits
          newBitList = BitList(newBlStr)
          chunks = newBitList.chunk(7)
          for chunk in chunks:
              strChunk = [str(bit) for bit in chunk]
              byteStr = ''.join(strChunk)
              decodeStr += chr(int(byteStr, 2))
      else:
          if(len(self.bits) % 8 != 0):
              raise DecodeError('Binary length is not a multiple of 8')
          decoded = self.bits;
          while decoded != '':
            bytesStr = ''
            chunkNum = 0
            if decoded[:1] != '0' and decoded[:3] != '110' and decoded[:4] != '1110' and decoded[:5] != '11110':
                raise DecodeError('Leading byte is invalid')
            if(decoded[:1] == '0'):
                chunkNum = 1
                bytesStr += decoded[1:8]
            elif(decoded[:3] == '110'):
                chunkNum = 2
                bytesStr += decoded[3:8]
            elif(decoded[:4] == '1110'):
                chunkNum = 3
                bytesStr += decoded[4:8]
            else:
                chunkNum = 4
                bytesStr += decoded[5:8]
            newBlStr = decoded[:chunkNum*8]
            newBitList = BitList(newBlStr)
            chunks = newBitList.chunk(8)
            chunks = chunks[1:]
            for chunk in chunks:
                if chunk[0] != 1 or chunk[1] != 0:
                    raise DecodeError('Continuation byte is invalid')
                strChunk = [str(bit) for bit in chunk[2:]]
                bytesStr += ''.join(strChunk)
            decodeStr += chr(int(bytesStr, 2))
            decoded = decoded[chunkNum*8:]
      return decodeStr
