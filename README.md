# Simple Audio Processing
This repository includes artefacts that I created in the course of doing tutorials 17 to 21 from https://www.beyond-circuits.com/wordpress/tutorial/

## Overview
The instructions below describe artefacts that are present in this repository and process of building and deploying the resultant application to ZedBoard. The instructions were created with the following in mind:

### Hardware:
- ZedBoard Rev. D
- source of audio connected to ZedBoard's Audio Jack Line In (BLUE).
- headphones connected to ZedBoard's Audio Jack Headphone Out (BLACK).

### Software:
- Ubuntu 16.04 LTS
- Vivado 2018.1

## Layout
The layout of the repository is as follows:

```
ps/
    ps/stopwatch.c - C code that is executed by the Processing System.

pl/ - artefacts relevant to the Programmable Logic - of the most importance are:
    ip_repo/ - location of IP source files .
        user.org_user_i2s_receiver_1.0/ - i2s_receiver.
        user.org_user_axi4_stream_delay_1.0/ - axi4_stream_delay.
        user.org_user_adau1761_controller_1.0/ - adau1761_controller.
        user.org_user_i2s_transmitter_1.0/ - i2s_transmitter

    src/ - source files that are not IPs.
        constraints/
            audio-processing.xdc - constraints file.
        verilog/
            sample-scaler.v - Verilog source for scaling samples to different sample widths.
            audio_processing_wrapper.v - Vivado generated wrapper that instantiates relevant modules.

ps/ - artefacts relevant to the Processing System - there is only one file there:
    audio-processing.c - functionality for initialising ADAU1761 audio codec.

README.md - this file.
recreate-project.tcl - Tcl script for creating Vivado project.
audio-processing.pdf - block diagram of the system.
audio-processing.3gp - video clip where the running system is presented.
```

## Building and Executing

1. In terminal, go to folder with git clone of this repository (`./`).
1. Execute:
    ```
    $ vivado -mode batch -source recreate-project.tcl
    ```
   If successful, you should see the following message from that execution:
     ```
     INFO: Project created:audio-processing
     ```
1. Open the created Vivado project (`./audio-processing/audio-processing.xpr`) in Vivado with **File > Project > Open**.
1. In the **Flow Navigator** panel find and select **Generate Bitstream**.
1. After the generation completes select **File > Export > Export Hardware...**.

    Make sure that the check box **Include bitstream** is selected.
1. Launch SDK with **File > Launch SDK**.
1. Within the SDK/Eclipse go to **File > New > Application Project**, for project name select _audio-processing_, and make the project **Empty Application**.
1. Back in the terminal change your working directory as follows:
    ```
    $ cd ./audio-processing/audio-processing.sdk/audio-processing/src
    ```
   and create a softlink to `ps/audio-processing.c` there, for example:
    ```
    $ ln -s ../../../../ps/audio-processing.c
    ```
1. Switch back to SDK/Eclipse and refresh the **Project Explorer** view.
1. Build the application with **Project > Build All**.
1. Once build completes, program your FPGA with `audio_processing_wrapper.bit` by means of **Xilinx > Program FPGA**.

   The blue LED Done should light up.
1. Run the audio-processing project with **Run > Run > Launch on Hardware (GDB)**.


You can see the whole system working in the uploaded video [`audio-processing.3gp`](https://github.com/zdzislaw-s/audio-processing/blob/master/audio-processing.3gp).

Note: Please refer to https://www.beyond-circuits.com/wordpress/tutorial/ for detailed discussion on this project.
