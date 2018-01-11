package sorting;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;

/**
 * A class used to transform an array of packets into a writable image and
 * renders that image to a file.
 * 
 * @author pattersp
 *
 */
public class PacketRenderer {
    // Some constants representing image height and width.
    // Do not worry about these. The server only sends images with
    // these dimensions.
    private static final int IMAGE_WIDTH = 400;
    private static final int IMAGE_HEIGHT = 533;

    /**
     * Takes in an array of packets, where each packets contains the bytes of an
     * image. It renders each packet in order of how it appears in the array. If
     * the packets are unsorted, the final image that is produced will be
     * identifiably scrambled. It is also possible that (if the packets are
     * unsorted) there will be black spaces in the image. This is normal and
     * expected, because different packets contain different amounts of bytes,
     * so if they are not sorted, the packets may not fit properly in rows.
     * The final image is rendered to the filename specified.
     * 
     * @param packets The array of packets that will be rendered.
     * @param filename The name of the file where the image should be written.
     */
    public static void renderImage(Packet[] packets, String filename) {
        System.out.println("Rendering packet array as image...");
        BufferedImage[] buffImages = createImagePieces(packets);
        int type = buffImages[0].getType();

        // Constructing the final image.
        // This will be a blank canvas, and we will paint the
        // packet data onto this.
        BufferedImage finalImage = new BufferedImage(IMAGE_WIDTH, IMAGE_HEIGHT,
                type);

        int xCoord = 0;
        int yCoord = 0;
        for (int i = 0; i < buffImages.length; i++) {
            finalImage.createGraphics().drawImage(buffImages[i], xCoord,
                    yCoord, null);
            xCoord += buffImages[i].getWidth();
            if (xCoord >= IMAGE_WIDTH) {
                xCoord = 0;
                yCoord += buffImages[i].getHeight();
            }
        }
        System.out.println("Rendering complete. Saving image to file " + filename + "...");
        try {
            ImageIO.write(finalImage, "jpeg", new File(filename));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        System.out.println("Complete. Refresh your Eclipse project (File -> Refresh) to view the image.");
    }

    /**
     * Converts the array of packets into an array of image pieces.
     * Each packet gets turned into one piece.
     * @param packets The array of packets representing image pixels.
     * @return an array of BufferedImage, one image per packet.
     */
    private static BufferedImage[] createImagePieces(Packet[] packets) {
        BufferedImage[] buffImages = new BufferedImage[packets.length];
        for (int i = 0; i < packets.length; i++) {
            byte[] bytes = packets[i].getDataBytes();
            InputStream byteInput = new ByteArrayInputStream(bytes);
            try {
                buffImages[i] = ImageIO.read(byteInput);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return buffImages;
    }
}
