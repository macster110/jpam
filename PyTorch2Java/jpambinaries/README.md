# JPAMBinaries

## About
JPAMBinaries is a Java library for extracting acoustic data from bespoke acoustic detection files. 

## Implemented file types
### AudioMoth
AudioMoth trigger files are imported using the org.jamdev.pambinaries.audiomoth package. The ```AudioMothTFile.loadTFile``` function extracts the raw wave data from each trigger chunk alongside sample time, time stamps parsed from the file name and then packages each raw wave data chunk and metadata to an AudioMothTData object. The importer returns an array of AudioMothTData objects for every imported file.  Example code is shown below

```
String file = "audiomoth/20200530_210400T.WAV";
String exportToFile = "audiomothchunk.mat"; 

		try {
			ArrayList<AudioMothTData> triggerChunks = AudioMothTFile.loadTFile(new File(file));

			for (AudioMothTData triggerChunk : triggerChunks) {
				System.out.println("---------------");
				System.out.println("Sample start: " + triggerChunk.sampleStart);
				System.out.println("Seconds start: " + triggerChunk.sampleStart/triggerChunk.sR);

				System.out.println("sR: " + triggerChunk.sR);
				System.out.println("TimeMillis: " + triggerChunk.timeMillis);
				System.out.println("Wave len: " + triggerChunk.wave.length);
				System.out.println("Max amp: " + max(triggerChunk.wave));
			}
			
			MatFile matFile = write2MAT(triggerChunks); 
			
			// Serialize to disk using default configurations
			Mat5.writeToFile(matFile,exportToFile);
		} 
		catch (UnsupportedAudioFileException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		catch (ParseException e) {
			e.printStackTrace();
		} 
```


### PAMGuard binary files
Code for imported binary files is avaialble in the PAMGuard repository however, these are tided to the PAMGuard API. The JPAMBinaries implementation provides a more functional programming library approach without the need to import the entire PAMGaurd API into porograms. 

## Maven
JPAMBinaries is available from Bintray. The Maven dependendency is

<dependency>
  <groupId>org.jamdev</groupId>
  <artifactId>jpambinaries</artifactId>
  <version>0.0.2</version>
  <type>pom</type>
</dependency>

make sure to also add the Bintray plugin. Instructions can be found on Bintray https://bintray.com/macster110/jpam/jpambinaries


