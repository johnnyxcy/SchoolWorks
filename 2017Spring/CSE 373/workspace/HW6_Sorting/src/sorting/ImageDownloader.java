package sorting;

/**
 * A runner class for testing out your PacketSorter's sorting methods. This
 * class will use PacketReceiver to get an array of scrambled packets from the
 * server. Then, it will use one of your sorting methods to unscramble the
 * packets. After the packets are sorted, you should use PacketRenderer to write
 * the image to a file titled finalImage.jpg.
 * 
 * TODO: You should call the appropriate method from PacketReceiver to download
 * the image pieces. Then, you will need to sort the packets using your
 * PacketSorter. Finally, use PacketRenderer to write the packets as an image to
 * a file.
 * 
 * Your final implementation can use either of your PacketSorter sorting
 * methods. However, be sure to test it with both! We will be testing both.
 * 
 * Your final implementation should be calling PacketReceiver.receivePackets(),
 * with no parameters. PacketReceiver.receivePackets() will connect to a remote
 * server hosted on attu.cs.washington.edu. After connecting, the server will
 * send over the bytes for an image in the form of packets. The server sends the
 * packets in a random order.
 * 
 * Debugging tips: Consider passing an integer to
 * PacketReceiver.receivePackets(). This integer is used as a seed to the
 * randomization. A seed guarantees that the random ordering of the packets are
 * consistent across multiple runs. By using a seed, you will be better able to
 * debug errors, because randomization will not be a factor.
 * 
 * Your final implementation must use receivePackets() without a parameter.
 * 
 * @author pattersp
 *
 */
public class ImageDownloader {
    public static void main(String[] args) {
        // TODO: Make the call to receive the packets
    	Packet[] input = PacketReceiver.receivePackets();
        // TODO: Sort the packets by calling one of your methods
    	PacketSorter.mergeSort(input, new PacketComparator());
        String imageOutputFilename = "finalImage.jpg";
        // TODO: Make the correct call to render the images
        PacketRenderer.renderImage(input, imageOutputFilename);
    }

}
