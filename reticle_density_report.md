# Google / Efabless GF180MCU Open MPW shuttle GFMPW-0 — Standard Cell & SRAM Density Report

**GF180MCU Process (GlobalFoundries 180nm), Shuttle GFMPW0**

## Introduction

This report analyzes the standard cell and SRAM density achieved by the 40 unique public chip designs on the Google / Efabless GF180MCU Open MPW shuttle GFMPW-0 reticle. The reticle has 40 slots; the public layout contains 40 slot placements (some designs appear more than once, and private designs are not included).

> **Partial measurement:** parts of every die are excluded from these figures; see [Methodology](#methodology).

All designs were fabricated on GlobalFoundries' GF180MCU process, a 180-nanometer (0.18um) technology node. This is a mature, relatively large-geometry process — for comparison, modern smartphone chips use 3nm or 5nm processes with features roughly 50x smaller.

> **Note on counting methodology:** All standard cell counts in this report count only **logic cells** — cells that perform actual computation (gates, flip-flops, buffers, multiplexers, etc.). Infrastructure cells are excluded: filler cells (fill, fillcap, endcap, filltie), well taps, antenna fix diodes, ESD diodes, and tie-high/tie-low cells. These infrastructure cells are inserted by automated tools to satisfy manufacturing rules but perform no logic function. On this reticle there are 2.0M infrastructure cell instances and 192k logic cell instances across the unique designs — 10.6 infrastructure cells for every logic cell.

## What Are Standard Cells?

A "standard cell" is a pre-designed, pre-verified building block used to construct digital circuits. Think of them like LEGO bricks for chip design: each cell performs one simple logic function (an AND gate, a flip-flop for storing one bit, a buffer for boosting signal strength), and a chip designer assembles thousands or millions of them to build complex circuits.

Standard cells in a library all share the same height (so they line up in rows) but vary in width depending on their function. Automated tools place these cells in rows and then route wires between them.

The "density" of standard cells — how many fit per square millimeter — is a key measure of how efficiently a design uses its silicon area. Higher density generally means more logic functionality packed into less chip area, which reduces cost.

## Standard Cell Libraries on This Reticle

| Library | Row Height | Rows per mm | Relative Density | Logic instances | Share |
|---|---|---|---|---|---|
| mcu7t5v0 (7-track, 5V) | 3.92 um | 255 rows | 100% | 192k | 100% |

Row height is the height of the cells' placement boundary, which is what rows are stacked at. Taller rows hold fewer cells per mm² but leave more room for wiring inside the cell.

## Theoretical Maximum Standard Cell Density

If you filled an entire square millimeter with nothing but one type of logic standard cell (no wiring, no gaps, no infrastructure cells), the theoretical maximum density would be:

| Cell Type | 7t-5V | What it does |
|---|---|---|
| Inverter | 114k/mm² (inv_1, 2.24um) | Flips a signal |
| NAND gate | 91k/mm² (nand2_1, 2.80um) | Basic logic gate |
| Buffer | 76k/mm² (buf_1, 3.36um) | Strengthens a signal |
| Flip-flop | 16k/mm² (dffq_1, 16.24um) | Stores one bit |

These are hard upper bounds — the density if you packed cells edge-to-edge with zero routing overhead. For each library the smallest cell of that kind is used; the 3.3V library has no drive strength 1 cells, so its smallest cells are the `_2` variants.

In practice, real designs achieve significantly less because:

- **(a) Routing overhead** — wires connecting cells need room, which limits how tightly cells can be placed
- **(b) Infrastructure cells** — fillers, taps, antenna diodes, and tie cells make up 91% of cell instances on this reticle
- **(c) Mixed cell types** — designs use a mix of small and large cells
- **(d) Power planning** — power/ground straps consume area
- **(e) Clock distribution** — clock tree buffers and wiring take space

## Achieved Standard Cell Density — Design Averages

The following tables show the average logic standard cell density for each design's "core area" — the interior of the chip excluding the I/O pad ring (a 350um border of large pads around the perimeter used for external connections).

"% of max" compares against the buffer theoretical maximum for the design's primary library. "Cell area" is the share of the core area actually covered by logic cells — the placement utilisation of the die as a whole, including any area left empty or given to SRAM.

### Medium Density (3k–10k logic SC/mm² core average)

| Design | Library | Core SC/mm² | % of max | Cell area | Logic SC | SRAM | Project |
|---|---|---|---|---|---|---|---|
| [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030) | 7t-5V | 7k | 9% | 17% | 65k | 0 | Ophelia eFPGA |
| [56C6](https://github.com/gatecat/one_hot_fpga_gf180) | 7t-5V | 4k | 5% | 11% | 32k | 0 | One-hot FABulous FPGA |
| [C979](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-014) | 7t-5V | 3k | 4% | 8% | 27k | 0 | VerilogBoy |

### Low Density (below 3k logic SC/mm² core average)

| Design | Library | Core SC/mm² | % of max | Cell area | Logic SC | SRAM | Project |
|---|---|---|---|---|---|---|---|
| [6079](https://github.com/gregdavill/gf180-mpw0-serv) | 7t-5V | 2k | 3% | 6% | 17k | 1 | Serv tri-core (GF180 MPW0 Serv) |
| [FF8E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-032) | 7t-5V | 1k | 2% | 5% | 13k | 0 | Hash accelerator with clock multiplexing |
| [B676](https://github.com/wokwi/gf180_spell) | 7t-5V | 1k | 1% | 2% | 6k | 0 | SPELL for GF180 |
| [66AD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-022) | 7t-5V | 1k | 1% | 1% | 6k | 0 | ALU (paper) |
| [105A](https://github.com/AvalonSemiconductors/AS2650) | 7t-5V | 1k | 1% | 1% | 5k | 0 | AS2650 |
| [F0DD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-031) | 7t-5V | <1k | 1% | 1% | 4k | 0 | Pyramiden Core (RV16U) |
| [8BB5](https://github.com/james-tandon-csueb/gf180-pwm) | 7t-5V | <1k | <1% | 1% | 2k | 0 | PWM / Wishbone core |
| [E91D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-013) | 7t-5V | <1k | <1% | <1% | 2k | 0 | EduRISC16 |
| [6E0D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-037) | 7t-5V | <1k | <1% | <1% | 2k | 0 | Synchronous modulator |
| [9DDB](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-038) | 7t-5V | <1k | <1% | <1% | 1k | 0 | Asynchronous modulator |
| [0ABD](https://github.com/russellfriesenhahn/gf180-russell) | 7t-5V | <1k | <1% | <1% | 1k | 0 | VGA Clock for GF180 |
| [9C7C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-018) | 7t-5V | <1k | <1% | <1% | 1k | 0 | GreenRio (GF version) |
| [1E9A](https://github.com/embelon/gf180-wb-hyperram) | 7t-5V | <1k | <1% | <1% | 1k | 0 | HyperRAM controller |

### Minimal (analog, custom or test structures)

These designs contain fewer than 1,000 logic standard cells:

| Design | Logic SC | Transistors | SRAM | Pads | Project |
|---|---|---|---|---|---|
| [0AFF](https://github.com/H-S-S-11/gf180-mpw0) | 151 | 82k | 0 | 63 | PDM driver and dice |
| [14FB](https://github.com/wokwi/gf180_skullfet) | 0 | 6 | 0 | 63 | SkullFET |
| [1F37](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-003) | 154 | 82k | 0 | 63 | Beep Boop Traffic Light Controller |
| [4515](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-012) | 24 | 181k | 0 | 63 | Tiny user project: inverter |
| [472A](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-028) | 727 | 110k | 0 | 63 | ChipFlow example SoC with 3.3V cells |
| [4F9E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-017) | 43 | 16k | 0 | 63 | MCU for solar power |
| [58D2](https://github.com/shaos/tiny_silicon_1) | 28 | 82k | 0 | 63 | TestFlipFlops |
| [5F3A](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-036) | 605 | 20k | 0 | 63 | Clock divider |
| [5FF2](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-023) | 77 | 82k | 0 | 63 | 74181 ALU |
| [6106](https://github.com/AyaseErii/gf180-FiveGuys) | 105 | 474k | 0 | 63 | FiveGuys |
| [679D](https://github.com/whutddk/Rift2Fake_gf180_mpw0) | 308 | 110k | 0 | 63 | Rift2Fake |
| [6F7B](https://github.com/urish/gf180-game-of-life-cell) | 43 | 82k | 0 | 63 | Game of Life cell |
| [7F0C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-019) | 182 | 109k | 0 | 63 | Universal gates |
| [8455](https://github.com/goEricBi/gf180_state_machine) | 88 | 110k | 0 | 63 | GF180 state machine |
| [8D82](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-034) | 48 | 82k | 0 | 63 | XLS bit population count |
| [A006](https://github.com/Gior-gio/5bitsMulti-gf180) | 163 | 110k | 0 | 63 | 5-bit multiplier |
| [A3A3](https://github.com/mcmorgul/gf180-multiplier-8-seq) | 0 | 16k | 0 | 63 | Signed 8-bit multiplier |
| [B22E](https://github.com/shaos/tiny_silicon_2) | 89 | 82k | 0 | 63 | TestAsyncTrimux |
| [BBE0](https://github.com/urielcho/posoco2000_gf180) | 115 | 16k | 0 | 63 | posoco2000 |
| [C301](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-024) | 201 | 82k | 0 | 63 | 8x8 Bit Pattern Player |
| [EAD1](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-021) | 44 | 82k | 0 | 63 | Reversible programmable logic IC |
| [EB3D](https://github.com/cpu-dev/caravel_jacaranda-8_GF180) | 727 | 110k | 0 | 63 | Jacaranda-8 8-bit CPU |
| [F330](https://github.com/rolfmobile99/tiny_user_project) | 388 | 82k | 0 | 63 | 16 x 4-bit dual port register file |
| [F4D8](https://github.com/AL-255/OpenFASOC_GF180_teststructures) | 727 | 110k | 0 | 63 | OpenFASoC test structures in GF180MCU |

## Achieved Density — Peak 1mm x 1mm Regions

While the averages above include sparse regions, the densest 1mm x 1mm square found anywhere on a design shows the highest density it achieved. The square slides over the die in 100um steps and may not touch an SRAM macro.

| Design | Peak Logic SC/mm² | % of buffer max | Library |
|---|---|---|---|
| [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030) | 19k | 25% of 76k | 7t-5V |
| [C979](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-014) | 18k | 24% of 76k | 7t-5V |
| [6079](https://github.com/gregdavill/gf180-mpw0-serv) | 12k | 16% of 76k | 7t-5V |
| [FF8E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-032) | 8k | 11% of 76k | 7t-5V |
| [B676](https://github.com/wokwi/gf180_spell) | 6k | 9% of 76k | 7t-5V |
| [66AD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-022) | 6k | 8% of 76k | 7t-5V |
| [56C6](https://github.com/gatecat/one_hot_fpga_gf180) | 5k | 7% of 76k | 7t-5V |
| [105A](https://github.com/AvalonSemiconductors/AS2650) | 5k | 6% of 76k | 7t-5V |
| [F0DD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-031) | 4k | 5% of 76k | 7t-5V |
| [8BB5](https://github.com/james-tandon-csueb/gf180-pwm) | 2k | 3% of 76k | 7t-5V |
| [E91D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-013) | 2k | 3% of 76k | 7t-5V |
| [6E0D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-037) | 2k | 2% of 76k | 7t-5V |
| [9DDB](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-038) | 1k | 2% of 76k | 7t-5V |
| [0ABD](https://github.com/russellfriesenhahn/gf180-russell) | 1k | 2% of 76k | 7t-5V |
| [9C7C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-018) | 1k | 2% of 76k | 7t-5V |

The highest achieved density on this reticle is 25% of the buffer theoretical maximum, observed in the densest 1mm² region of [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030). The rest of that area is consumed by larger cells, infrastructure cells and the gaps left for routing.

## Most Common Logic Cell Types

The 15 most-used logic cell types across all unique designs on the reticle:

| Cell Type | Library | Instances | What it does |
|---|---|---|---|
| nand2_1 | 7t-5V | 24k | 2-input NAND gate |
| clkbuf_1 | 7t-5V | 23k | Clock buffer |
| dffq_1 | 7t-5V | 19k | D flip-flop (1 bit storage) |
| buf_1 | 7t-5V | 15k | Buffer |
| oai21_1 | 7t-5V | 13k | OR-AND-Invert compound gate |
| clkinv_1 | 7t-5V | 9k | Clock inverter |
| nor2_1 | 7t-5V | 9k | 2-input NOR gate |
| bufz_1 | 7t-5V | 8k | Tri-state buffer |
| nand3_1 | 7t-5V | 6k | 3-input NAND gate |
| latq_1 | 7t-5V | 6k | Latch (level-sensitive) |
| aoi21_1 | 7t-5V | 6k | AND-OR-Invert compound gate |
| mux2_2 | 7t-5V | 4k | 2-input multiplexer (2x drive) |
| mux4_1 | 7t-5V | 4k | 4-input multiplexer |
| oai211_1 | 7t-5V | 4k | OR-AND-Invert compound gate |
| clkbuf_16 | 7t-5V | 3k | Clock buffer (16x drive) |

Across the reticle there are 25k 2-input NAND gates and 21k flip-flops — 1.2 NAND2 gates per flip-flop.

## SRAM Block Usage

SRAM (Static Random-Access Memory) blocks are pre-designed memory macros. Unlike standard cells, which are composed by automated tools, SRAM blocks are hand-optimized fixed-size units designed to store data as densely as possible.

1 of the 40 designs include SRAM, holding 0 KiB of memory between them:

| Design | SRAM macros | SRAM bits | SRAM area | Logic SC | Project |
|---|---|---|---|---|---|
| [6079](https://github.com/gregdavill/gf180-mpw0-serv) | 1 | 2,048 | 0.15 mm² (2% of core) | 17k | Serv tri-core (GF180 MPW0 Serv) |

SRAM macros are identified by cell name, and their area is the macro footprint. "custom" marks a design with SRAM marker shapes (GDS 108/5) but no recognised macro, where the count and size are not known and the area is that of the marked bitcell arrays.

## SRAM vs Standard Cell Transistor Density

"Transistor density" here counts the number of distinct regions where a gate electrode (polysilicon, GDS 30/0) crosses an active area (diffusion, GDS 22/0) — each such crossing forms one transistor.

### Theoretical Maximum Transistor Density for Standard Cells

| Cell (7t-5V) | Width | Cells/mm² | Trans/cell | Trans/mm² theoretical max |
|---|---|---|---|---|
| inv_1 | 2.24 um | 114k | 2 | 228k/mm² |
| nand2_1 | 2.80 um | 91k | 4 | 364k/mm² |
| buf_1 | 3.36 um | 76k | 4 | 304k/mm² |
| dffq_1 | 16.24 um | 16k | 24 | 377k/mm² |

### SRAM Macros

| Macro | Size | Trans/mm² | % of flip-flop max | Placements |
|---|---|---|---|---|
| `gf180mcu_fd_ip_sram__sram512x8m8wm1` | 432 x 485 um | 154k/mm² | 41% | 0 |
| `gf180mcu_fd_ip_sram__sram256x8m8wm1` | 432 x 341 um | 124k/mm² | 33% | 1 |

The macro density includes the peripheral circuits (address decoders, sense amplifiers, I/O drivers) around the bitcell array, which is why larger macros of a family are denser than smaller ones.

### Best Standard Cell Regions

| Design | Peak 1mm² Trans/mm² | % of flip-flop max | Library |
|---|---|---|---|
| [FF8E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-032) | 250k/mm² | 66% | 7t-5V |
| [C979](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-014) | 230k/mm² | 61% | 7t-5V |
| [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030) | 198k/mm² | 53% | 7t-5V |
| [E91D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-013) | 189k/mm² | 50% | 7t-5V |
| [6079](https://github.com/gregdavill/gf180-mpw0-serv) | 181k/mm² | 48% | 7t-5V |
| [B676](https://github.com/wokwi/gf180_spell) | 170k/mm² | 45% | 7t-5V |
| [6106](https://github.com/AyaseErii/gf180-FiveGuys) | 168k/mm² | 44% | 7t-5V |
| [4515](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-012) | 154k/mm² | 41% | 7t-5V |

Infrastructure cells are excluded from logic cell counts but their transistors (decoupling capacitors in particular) are included in transistor counts.

## Process Features and Voltages

Which transistor voltages and optional devices of the GF180MCU process the 40 designs use. Voltages count both the libraries a design chose (standard cells and SRAM) and transistors the designer drew. Devices count only what the designer drew: standard cells, SRAM macros, I/O pads and fill are left out, because every die has them. A single test structure counts the same as a large block.

| Transistor voltage | Designs | Which |
|---|---|---|
| 5 V | 38 of 40 | `0ABD`, `0AFF`, `105A`, `1E9A`, `1F37`, `4515`, `45D6`, `472A`, `4F9E`, `56C6`, `58D2`, `5F3A`, `5FF2`, `6079`, `6106`, `66AD`, `679D`, `6E0D`, `6F7B`, `7F0C`, `8455`, `8BB5`, `8D82`, `9C7C`, `9DDB`, `A006`, `B22E`, `B676`, `BBE0`, `C301`, `C979`, `E91D`, `EAD1`, `EB3D`, `F0DD`, `F330`, `F4D8`, `FF8E` |
| 6 V | 2 of 40 | `14FB`, `45D6` |

| Device | Designs drawing it | Which |
|---|---|---|
| eFuses | 1 of 40 | `45D6` |
| Native transistors | 0 of 40 | — |
| 10 V LDMOS | 0 of 40 | — |
| MIM capacitors | 0 of 40 | — |
| MOS capacitors | 0 of 40 | — |
| High-resistance poly resistors | 0 of 40 | — |
| Unsalicided poly resistors | 0 of 40 | — |
| Salicided poly resistors | 0 of 40 | — |
| Diffusion resistors | 0 of 40 | — |
| Deep N-well | 0 of 40 | — |
| Bipolar transistors | 0 of 40 | — |
| Schottky diodes | 0 of 40 | — |
| Zener diodes | 0 of 40 | — |
| One-time programmable memory | 0 of 40 | — |
| Inductors | 0 of 40 | — |

| Design | Voltages | Custom transistors 3.3 / 5 / 6 V | Devices drawn | I/O library |
|---|---|---|---|---|
| [0ABD](https://github.com/russellfriesenhahn/gf180-russell) | 5 V | 0 / 0 / 0 | — | — |
| [0AFF](https://github.com/H-S-S-11/gf180-mpw0) | 5 V | 0 / 0 / 0 | — | — |
| [105A](https://github.com/AvalonSemiconductors/AS2650) | 5 V | 0 / 0 / 0 | — | — |
| [14FB](https://github.com/wokwi/gf180_skullfet) | 6 V | 0 / 0 / 6 | — | — |
| [1E9A](https://github.com/embelon/gf180-wb-hyperram) | 5 V | 0 / 0 / 0 | — | — |
| [1F37](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-003) | 5 V | 0 / 0 / 0 | — | — |
| [4515](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-012) | 5 V | 0 / 0 / 0 | — | — |
| [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030) | 5 V, 6 V | 0 / 5,184 / 9,216 | eFuses | — |
| [472A](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-028) | 5 V | 0 / 0 / 0 | — | — |
| [4F9E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-017) | 5 V | 0 / 0 / 0 | — | — |
| [56C6](https://github.com/gatecat/one_hot_fpga_gf180) | 5 V | 0 / 297,328 / 0 | — | — |
| [58D2](https://github.com/shaos/tiny_silicon_1) | 5 V | 0 / 0 / 0 | — | — |
| [5F3A](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-036) | 5 V | 0 / 0 / 0 | — | — |
| [5FF2](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-023) | 5 V | 0 / 0 / 0 | — | — |
| [6079](https://github.com/gregdavill/gf180-mpw0-serv) | 5 V | 0 / 0 / 0 | — | — |
| [6106](https://github.com/AyaseErii/gf180-FiveGuys) | 5 V | 0 / 0 / 0 | — | — |
| [66AD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-022) | 5 V | 0 / 0 / 0 | — | — |
| [679D](https://github.com/whutddk/Rift2Fake_gf180_mpw0) | 5 V | 0 / 0 / 0 | — | — |
| [6E0D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-037) | 5 V | 0 / 0 / 0 | — | — |
| [6F7B](https://github.com/urish/gf180-game-of-life-cell) | 5 V | 0 / 0 / 0 | — | — |
| [7F0C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-019) | 5 V | 0 / 0 / 0 | — | — |
| [8455](https://github.com/goEricBi/gf180_state_machine) | 5 V | 0 / 0 / 0 | — | — |
| [8BB5](https://github.com/james-tandon-csueb/gf180-pwm) | 5 V | 0 / 0 / 0 | — | — |
| [8D82](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-034) | 5 V | 0 / 0 / 0 | — | — |
| [9C7C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-018) | 5 V | 0 / 0 / 0 | — | — |
| [9DDB](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-038) | 5 V | 0 / 0 / 0 | — | — |
| [A006](https://github.com/Gior-gio/5bitsMulti-gf180) | 5 V | 0 / 0 / 0 | — | — |
| [A3A3](https://github.com/mcmorgul/gf180-multiplier-8-seq) | — | 0 / 0 / 0 | — | — |
| [B22E](https://github.com/shaos/tiny_silicon_2) | 5 V | 0 / 0 / 0 | — | — |
| [B676](https://github.com/wokwi/gf180_spell) | 5 V | 0 / 0 / 0 | — | — |
| [BBE0](https://github.com/urielcho/posoco2000_gf180) | 5 V | 0 / 0 / 0 | — | — |
| [C301](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-024) | 5 V | 0 / 0 / 0 | — | — |
| [C979](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-014) | 5 V | 0 / 0 / 0 | — | — |
| [E91D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-013) | 5 V | 0 / 0 / 0 | — | — |
| [EAD1](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-021) | 5 V | 0 / 0 / 0 | — | — |
| [EB3D](https://github.com/cpu-dev/caravel_jacaranda-8_GF180) | 5 V | 0 / 0 / 0 | — | — |
| [F0DD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-031) | 5 V | 0 / 0 / 0 | — | — |
| [F330](https://github.com/rolfmobile99/tiny_user_project) | 5 V | 0 / 0 / 0 | — | — |
| [F4D8](https://github.com/AL-255/OpenFASOC_GF180_teststructures) | 5 V | 0 / 0 / 0 | — | — |
| [FF8E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-032) | 5 V | 0 / 0 / 0 | — | — |

Detection uses the open GF180MCU layers: a transistor is gate polysilicon (30/0) over diffusion (22/0), thick oxide inside Dualgate (55/0), 5 V where V5_XTOR (112/1) also covers it and 6 V where it does not; MIM capacitors are FuseTop (75/0) shapes; poly resistors are Poly2 under RES_MK (110/5), high resistance under the Resistor layer (62/0) and otherwise unsalicided under SAB (49/0) or salicided. Other devices are found by their marker layers.

## Key Findings

1. The densest logic standard cell design, [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030) (Ophelia eFPGA), achieves **7k logic SC/mm²** averaged over its core (9% of buffer max), with a peak of **19k logic SC/mm²** in its densest 1mm² region.

2. Standard cell libraries in use: **7t-5V** (100% of logic cells).

3. The median digital design achieves **<1k logic SC/mm²** over its core. 0 of 16 designs exceed 10k logic SC/mm².

4. The best standard cell region reaches **250k transistors/mm²** ([FF8E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-032)); the most used SRAM macro, `gf180mcu_fd_ip_sram__sram256x8m8wm1`, is 124k transistors/mm².

5. Infrastructure cells (fillers, taps, antenna diodes, ties) outnumber logic cells **10.6 to 1** across the reticle (2.0M vs 192k). Any density analysis must exclude these to avoid dramatically overstating actual logic content.

6. The most common logic cell is **nand2_1** (24k instances in 7t-5V).

## Per-Design Details

| Design | Cell | Die (mm) | Core mm² | Placements | Pads | Logic SC | Infra SC | Transistors | SRAM | Libraries |
|---|---|---|---|---|---|---|---|---|---|---|
| [0ABD](https://github.com/russellfriesenhahn/gf180-russell) | `0ABD_caravel_14_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 1,319 | 8,052 | 33,316 | 0 | mcu7t5v0: 1,319 |
| [0AFF](https://github.com/H-S-S-11/gf180-mpw0) | `0AFF_caravel_14_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 151 | 11,248 | 82,355 | 0 | mcu7t5v0: 151 |
| [105A](https://github.com/AvalonSemiconductors/AS2650) | `105A_caravel_4_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 4,846 | 33,191 | 106,901 | 0 | mcu7t5v0: 4,846 |
| [14FB](https://github.com/wokwi/gf180_skullfet) | `14FB_caravel_12_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 0 | 0 | 6 | 0 | — |
| [1E9A](https://github.com/embelon/gf180-wb-hyperram) | `1E9A_caravel_4_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 1,155 | 8,477 | 30,657 | 0 | mcu7t5v0: 1,155 |
| [1F37](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-003) | `1F37_caravel_14_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 154 | 11,448 | 82,002 | 0 | mcu7t5v0: 154 |
| [4515](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-012) | `4515_caravel_10_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 24 | 22,849 | 181,320 | 0 | mcu7t5v0: 24 |
| [45D6](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-030) | `45D6_caravel_4_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 64,755 | 323,611 | 1,074,960 | 0 | mcu7t5v0: 64,755 |
| [472A](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-028) | `472A_caravel_4_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 727 | 15,874 | 109,729 | 0 | mcu7t5v0: 727 |
| [4F9E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-017) | `4F9E_caravel_8_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 43 | 2,593 | 16,495 | 0 | mcu7t5v0: 43 |
| [56C6](https://github.com/gatecat/one_hot_fpga_gf180) | `56C6_caravel_12_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 32,037 | 689,411 | 1,319,690 | 0 | mcu7t5v0: 32,037 |
| [58D2](https://github.com/shaos/tiny_silicon_1) | `58D2_caravel_6_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 28 | 10,855 | 82,246 | 0 | mcu7t5v0: 28 |
| [5F3A](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-036) | `5F3A_caravel_0_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 605 | 4,237 | 19,638 | 0 | mcu7t5v0: 605 |
| [5FF2](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-023) | `5FF2_caravel_6_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 77 | 11,033 | 82,176 | 0 | mcu7t5v0: 77 |
| [6079](https://github.com/gregdavill/gf180-mpw0-serv) | `6079_caravel_14_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 17,345 | 96,994 | 359,685 | 1 | mcu7t5v0: 17,345 |
| [6106](https://github.com/AyaseErii/gf180-FiveGuys) | `6106_caravel_8_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 105 | 58,276 | 474,200 | 0 | mcu7t5v0: 105 |
| [66AD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-022) | `66AD_caravel_6_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 5,960 | 26,772 | 71,484 | 0 | mcu7t5v0: 5,960 |
| [679D](https://github.com/whutddk/Rift2Fake_gf180_mpw0) | `679D_caravel_10_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 308 | 14,945 | 109,582 | 0 | mcu7t5v0: 308 |
| [6E0D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-037) | `6E0D_caravel_0_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 1,558 | 7,532 | 15,966 | 0 | mcu7t5v0: 1,558 |
| [6F7B](https://github.com/urish/gf180-game-of-life-cell) | `6F7B_caravel_12_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 43 | 10,892 | 82,266 | 0 | mcu7t5v0: 43 |
| [7F0C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-019) | `7F0C_caravel_8_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 182 | 14,489 | 109,489 | 0 | mcu7t5v0: 182 |
| [8455](https://github.com/goEricBi/gf180_state_machine) | `8455_caravel_0_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 88 | 13,991 | 109,567 | 0 | mcu7t5v0: 88 |
| [8BB5](https://github.com/james-tandon-csueb/gf180-pwm) | `8BB5_caravel_0_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 2,471 | 24,410 | 108,042 | 0 | mcu7t5v0: 2,471 |
| [8D82](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-034) | `8D82_caravel_2_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 48 | 10,901 | 82,255 | 0 | mcu7t5v0: 48 |
| [9C7C](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-018) | `9C7C_caravel_8_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 1,319 | 8,052 | 33,316 | 0 | mcu7t5v0: 1,319 |
| [9DDB](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-038) | `9DDB_caravel_0_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 1,470 | 6,826 | 16,000 | 0 | mcu7t5v0: 1,470 |
| [A006](https://github.com/Gior-gio/5bitsMulti-gf180) | `A006_caravel_2_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 163 | 14,337 | 109,626 | 0 | mcu7t5v0: 163 |
| [A3A3](https://github.com/mcmorgul/gf180-multiplier-8-seq) | `A3A3_caravel_12_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 0 | 2,385 | 16,376 | 0 | — |
| [B22E](https://github.com/shaos/tiny_silicon_2) | `B22E_caravel_4_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 89 | 10,989 | 82,220 | 0 | mcu7t5v0: 89 |
| [B676](https://github.com/wokwi/gf180_spell) | `B676_caravel_10_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 6,463 | 42,067 | 170,147 | 0 | mcu7t5v0: 6,463 |
| [BBE0](https://github.com/urielcho/posoco2000_gf180) | `BBE0_caravel_8_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 115 | 2,726 | 16,480 | 0 | mcu7t5v0: 115 |
| [C301](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-024) | `C301_caravel_6_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 201 | 11,638 | 82,400 | 0 | mcu7t5v0: 201 |
| [C979](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-014) | `C979_caravel_10_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 27,097 | 148,645 | 492,322 | 0 | mcu7t5v0: 27,097 |
| [E91D](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-013) | `E91D_caravel_10_4` | 3.93 x 5.12 | 9.0 | 1 | 63 | 2,034 | 31,767 | 207,791 | 0 | mcu7t5v0: 2,034 |
| [EAD1](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-021) | `EAD1_caravel_6_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 44 | 10,903 | 82,244 | 0 | mcu7t5v0: 44 |
| [EB3D](https://github.com/cpu-dev/caravel_jacaranda-8_GF180) | `EB3D_caravel_12_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 727 | 15,874 | 109,729 | 0 | mcu7t5v0: 727 |
| [F0DD](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-031) | `F0DD_caravel_2_8` | 3.93 x 5.12 | 9.0 | 1 | 63 | 3,874 | 25,899 | 81,479 | 0 | mcu7t5v0: 3,874 |
| [F330](https://github.com/rolfmobile99/tiny_user_project) | `F330_caravel_2_0` | 3.93 x 5.12 | 9.0 | 1 | 63 | 388 | 12,634 | 82,161 | 0 | mcu7t5v0: 388 |
| [F4D8](https://github.com/AL-255/OpenFASOC_GF180_teststructures) | `F4D8_caravel_14_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 727 | 15,874 | 109,729 | 0 | mcu7t5v0: 727 |
| [FF8E](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-000/slot-032) | `FF8E_caravel_2_6` | 3.93 x 5.12 | 9.0 | 1 | 63 | 12,962 | 248,775 | 1,951,950 | 0 | mcu7t5v0: 12,962 |

## Methodology

- **Logic cell counts** come from walking the layout hierarchy and counting instances of every cell whose name contains a standard cell library prefix, excluding types starting with `fill`, `endcap`, `filltie`, `fillcap`, `tap`, `antenna`, `diode`, `tiel`, `tieh`.
- **Transistor counts** are the number of merged polygons in the boolean AND of the diffusion (22/0) and gate polysilicon (30/0) layers, leaving out dummy fill cells, whose diffusion and polysilicon squares overlap without forming transistors.
- **Core area** is the area of each design's `user_project_wrapper` cell.
- **Cell dimensions** are the width and height of each standard cell's placement boundary (GDS 0/0), measured from the cells present in this layout.
- **Theoretical maximum** = (1000um / cell width) x (1000um / row height).
- **Missing placement boundaries:** 164 standard cells in this layout have no placement boundary (GDS 0/0). For 164 of them the boundary measured from the wafer.space Run 1 and Run 2 layouts of the same cell is used.
- **Peak figures** are the densest 1mm x 1mm square anywhere inside each die, found by sliding the square in 100um steps over the die and skipping positions that touch an SRAM macro. Logic cells are placed by their origin and transistors by the centre of their gate.
- **SRAM macros** are counted by cell name. The `sram_block_count` column of the summary CSV is kept for comparison with earlier results; it counts SramCore marker shapes, of which each GF180MCU macro has two.
- Designs placed more than once on the reticle are counted once.
- **Excluded from the measurements:** pad ring (`gf180mcu_*_io__*`); caravel harness (`caravel_core`, `caravel_power_routing`, `chip_io`, `caravel_logo`, `caravel_motto`, `copyright_block`, `open_source`, `user_id_textblock`); seal ring (`sealring`). Cells matching `user_project_wrapper` are measured even inside those. Logic cell, transistor and SRAM figures therefore cover only part of each die and are not directly comparable with reports that measure whole dies. Die sizes are measured on the whole die, and bond pads on the whole die apart from its seal ring.

---

*Generated by [ws-run-reports](https://github.com/wafer-space/ws-run-reports) from `GFMPW0.oas` (md5 `366739415ab37e49a4330761db15c940`) in [wafer-space/google-gf180mcu-mpw0](https://github.com/wafer-space/google-gf180mcu-mpw0). Analysis method: KLayout boolean geometry operations on GDS layers. Grid resolution: 1mm x 1mm. Density figures are rounded to the nearest 1k.*
