#include "xil_io.h"
#include "adau1761_controller.h"
#include "xparameters.h"
#define AUDIO_BASE XPAR_ADAU1761_CONTROLLER_0_S00_AXI_BASEADDR

#define CTRL_ADDR ADAU1761_CONTROLLER_S00_AXI_SLV_REG0_OFFSET
#define BUSY_ADDR ADAU1761_CONTROLLER_S00_AXI_SLV_REG1_OFFSET
#define WRITE_LOW_DATA_ADDR ADAU1761_CONTROLLER_S00_AXI_SLV_REG2_OFFSET
#define WRITE_HIGH_DATA_ADDR ADAU1761_CONTROLLER_S00_AXI_SLV_REG3_OFFSET
#define READ_LOW_DATA_ADDR ADAU1761_CONTROLLER_S00_AXI_SLV_REG4_OFFSET
#define READ_HIGH_DATA_ADDR ADAU1761_CONTROLLER_S00_AXI_SLV_REG5_OFFSET

#define RESET_POS 25
#define START_POS 24
#define READ_POS 19
#define NBYTES_POS 16
#define ADDR_POS 0

void write_adau1761(uint32_t addr, uint64_t data, uint32_t nbytes) {
    uint32_t busy;
    uint32_t control_word = (nbytes - 1) << NBYTES_POS | addr << ADDR_POS;
    uint32_t data_low = data << (8 * (8 - nbytes));
    uint32_t data_high = (data << (8 * (8 - nbytes))) >> 32;
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, WRITE_LOW_DATA_ADDR, data_low);
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, WRITE_HIGH_DATA_ADDR, data_high);
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, CTRL_ADDR, control_word);
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, CTRL_ADDR, control_word | (1<<START_POS));
    while ((busy = ADAU1761_CONTROLLER_mReadReg(AUDIO_BASE, BUSY_ADDR)))
        ;
}

uint64_t read_adau1761(uint32_t addr, uint32_t nbytes) {
    uint32_t busy;
    uint32_t control_word = 1 << READ_POS | (nbytes - 1) << NBYTES_POS | addr << ADDR_POS;
    uint64_t data_low;
    uint64_t data_high;
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, CTRL_ADDR, control_word);
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, CTRL_ADDR, control_word | (1<<START_POS));
    while ((busy = ADAU1761_CONTROLLER_mReadReg(AUDIO_BASE, BUSY_ADDR)))
        ;
    data_low = ADAU1761_CONTROLLER_mReadReg(AUDIO_BASE, READ_LOW_DATA_ADDR);
    data_high = ADAU1761_CONTROLLER_mReadReg(AUDIO_BASE, READ_HIGH_DATA_ADDR);
    return ((data_high << 32) | data_low) & ((1LL << 8 * nbytes) - 1);
}

void reset_adau1761(void) {
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, CTRL_ADDR, 1<<RESET_POS);
    ADAU1761_CONTROLLER_mWriteReg(AUDIO_BASE, CTRL_ADDR, 0);
    read_adau1761(0, 1);
    read_adau1761(0, 1);
    read_adau1761(0, 1);
}

void init_adau1761(void) {
    volatile int i;
    //  setup PLL
    write_adau1761(0x4000, 0x0e, 1);
    //  Configure PLL
    write_adau1761(0x4002, 0x007d000c2301, 6);
    //  Wait for PLL to lock
    while (!(read_adau1761(0x4002, 6) & 2))
        ;
    //  Enable clock to core
    write_adau1761(0x4000, 0xf, 1);
    //  delay
    for (i = 0; i < 1000000; i++)
        ;
    //  I2S master mode
    write_adau1761(0x4015, 0x01, 1);
    //  left mixer enable
    write_adau1761(0x400a, 0x01, 1);
    //  left 0db
    write_adau1761(0x400b, 0x05, 1);
    //  right mixer enable
    write_adau1761(0x400c, 0x01, 1);
    //  right 0db
    write_adau1761(0x400d, 0x05, 1);
    //  Playback left mixer unmute, enable
    write_adau1761(0x401c, 0x21, 1);
    //  Playback right mixer unmute, enable
    write_adau1761(0x401e, 0x41, 1);
    //  Enable headphone output left
    write_adau1761(0x4023, 0xe7, 1);
    //  Enable headphone output right
    write_adau1761(0x4024, 0xe7, 1);
    //  Enable line out left
    write_adau1761(0x4025, 0xe7, 1);
    //  Enable line out right
    write_adau1761(0x4026, 0xe7, 1);
    //  Enable both ADCs
    write_adau1761(0x4019, 0x03, 1);
    //  Enable playback both channels
    write_adau1761(0x4029, 0x03, 1);
    //  Enable both DACs
    write_adau1761(0x402a, 0x03, 1);
    //  Serial input L0,R0 to DAC L,R
    write_adau1761(0x40f2, 0x01, 1);
    //  Serial output ADC L,R to serial output L0,R0
    write_adau1761(0x40f3, 0x01, 1);
    //  Enable clocks to all engines
    write_adau1761(0x40f9, 0x7f, 1);
    //  Enable both clock generators
    write_adau1761(0x40fa, 0x03, 1);
}

int main(void) {
    reset_adau1761();
    init_adau1761();
}
