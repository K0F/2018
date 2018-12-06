import java.io.FileInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPInputStream;

GzipReader gz;

void setup(){
size(800,200);
  gz = new GzipReader("/home/kof/Downloads/qc_data/QC_FILES/11_Zadem_k_nekonečnu_screener_tc_logo.xml.gz");

}

void draw(){

  for(int i = 0 ; i<gz.rgbs.size();i++){
    color c = (Integer)gz.rgbs.get(i);
    stroke(c,50);
    line(map(i,0,gz.rgbs.size(),0,width),0,map(i,0,gz.rgbs.size(),0,width),height);
  }
}

public class GzipReader
{
  String data[];
  ArrayList Ys,Us,Vs;
  ArrayList rgbs;

  GzipReader(String filename)
  {
    Ys = new ArrayList();
    Us = new ArrayList();
    Vs = new ArrayList();
    rgbs = new ArrayList();

    // open the input (compressed) file.
    try{
      FileInputStream stream = new FileInputStream(filename);
      ByteArrayOutputStream output = null;
      try
      {
        // open the gziped file to decompress.
        GZIPInputStream gzipstream = new GZIPInputStream(stream);
        byte[] buffer = new byte[2048];

        // create the output file without the .gz extension.
        output = new ByteArrayOutputStream();

        // and copy it to a new file
        int len;
        while((len = gzipstream.read(buffer ))>0)
        {
          output.write(buffer, 0, len);
        }
        String raw = new String(output.toByteArray(), "UTF-8");
        data = split(raw,'\n');
        
        for(int i = 0; i < data.length;i++){
          if(data[i].indexOf("lavfi.signalstats.YAVG")>-1){
            Ys.add(parseFloat(split(data[i],'\"')[3]));
          }
          if(data[i].indexOf("lavfi.signalstats.UAVG")>-1){
            Us.add(parseFloat(split(data[i],'\"')[3]));
          }
          if(data[i].indexOf("lavfi.signalstats.VAVG")>-1){
            Vs.add(parseFloat(split(data[i],'\"')[3]));
          }
        }

        for(int i = 0 ; i < Ys.size();i++){
          float y = (Float)Ys.get(i);
          float u = (Float)Us.get(i);
          float v = (Float)Vs.get(i);
          int[] rgb = yuv_to_rgb(y,u,v);
          rgbs.add(color(rgb[0],rgb[1],rgb[2]));
        }
      }
      finally
      {
        // both streams must always be closed.
        if(output != null) output.close();
        stream.close();
      }
    }catch(Exception e){
      println(e);
    }
  }
}

int[] yuv_to_rgb(float y, float u, float v){

  int r,g,b;

  // u and v are +-0.5
  u -= 128;
  v -= 128;

  // Conversion
  r = (int)(y + 1.370705 * v);
  g = (int)(y - 0.698001 * v - 0.337633 * u);
  b = (int)(y + 1.732446 * u);
  // Clamp to 0..1

  if (r < 0) r = 0;
  if (g < 0) g = 0;
  if (b < 0) b = 0;
  if (r > 255) r = 255;
  if (g > 255) g = 255;
  if (b > 255) b = 255;

  return new int[]{r,g,b};
}
