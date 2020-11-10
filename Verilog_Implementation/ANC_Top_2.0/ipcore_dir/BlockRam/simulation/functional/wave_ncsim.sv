

 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /BlockRam_tb/status
      waveform add -signals /BlockRam_tb/BlockRam_synth_inst/bmg_port/CLKA
      waveform add -signals /BlockRam_tb/BlockRam_synth_inst/bmg_port/ADDRA
      waveform add -signals /BlockRam_tb/BlockRam_synth_inst/bmg_port/DINA
      waveform add -signals /BlockRam_tb/BlockRam_synth_inst/bmg_port/WEA
      waveform add -signals /BlockRam_tb/BlockRam_synth_inst/bmg_port/ENA
      waveform add -signals /BlockRam_tb/BlockRam_synth_inst/bmg_port/DOUTA

console submit -using simulator -wait no "run"
