import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;


void setup(){

  byte raw[] = loadBytes("/home/kof/Downloads/qc_data/QC_FILES/12345_ZF415_1526462465_screener-printrip_tc_logo.xml.gz");
  println(raw.length);
  try{
    String test = decompress(raw)+"";
    print(test);
  }catch(Exception e){;}
}




void draw(){


}

String decompress(byte[] compressed) throws IOException {
  StringBuilder outStr = new StringBuilder();
  GZIPInputStream gis = new GZIPInputStream(new ByteArrayInputStream(compressed));
  BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(gis, "UTF-8"));

  String line;
  while ((line = bufferedReader.readLine()) != null) {
    outStr.append(line);
  }
  return outStr.toString();
}

boolean isCompressed(final byte[] compressed) {
  return (compressed[0] == (byte) (GZIPInputStream.GZIP_MAGIC)) && (compressed[1] == (byte) (GZIPInputStream.GZIP_MAGIC >> 8));
}

