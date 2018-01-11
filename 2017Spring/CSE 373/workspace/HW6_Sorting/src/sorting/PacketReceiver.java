package sorting;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.Socket;

/**
 * This class is used to connect to a remote host to download image packets. The
 * class will start up a connection with the remote server and send a request.
 * In response to the request, the server will send back bytes of an image.
 * 
 * This class will transform those bytes into an array of Packet objects.
 * 
 * 
 * @author pattersp
 *
 */
public class PacketReceiver {
    public static final int MY_STUDENT_NUMBER = 1531273;
    
    public static final int PORT_NUMBER = 33333;
    // connect to attu1
    public static final String HOST_NAME = "attu" + (MY_STUDENT_NUMBER % 4 + 1) + ".cs.washington.edu";
    public static final int NO_SEED_FLAG = -1;

    /**
     * Connects to the remote host and requests the image bytes using no seed.
     * 
     * @return An array of packets, unsorted.
     */
    public static Packet[] receivePackets() {
        return receivePackets(NO_SEED_FLAG);
    }

    /**
     * Connects to the remote host and requests the image bytes.
     * 
     * @param seed
     *            The seed that will be sent to the server to eliminate
     *            randomization.
     * @return An array of packets, unsorted.
     */
    public static Packet[] receivePackets(int seed) {
        System.out.println("Opening connection with remote server...");
        try (Socket tcpSocket = new Socket(HOST_NAME, PORT_NUMBER);
                InputStream in = tcpSocket.getInputStream();
                OutputStream out = tcpSocket.getOutputStream();) {
            DataOutputStream dos = new DataOutputStream(out);
            // Send the server the seed that will be used for the random
            // generator.
            System.out.println("Sending request...");
            dos.writeInt(seed);
            DataInputStream dis = new DataInputStream(in);
            // The first number sent by the server will be the number of
            // packets.
            System.out.println("Waiting for server to respond...");
            int len = dis.readInt();
            Packet[] packets = new Packet[len];
            System.out.println("Starting download...");
            for (int i = 0; i < len; i++) {
                // Each packet will be preceded by a packet specifying its
                // length
                int packetSize = dis.readInt();
                byte[] packetBytes = new byte[packetSize];
                dis.readFully(packetBytes);
                packets[i] = new Packet(packetBytes);
            }
            System.out.println("Download complete.");
            return packets;

        } catch (ConnectException e) {
            throw new IllegalStateException(
                    "Caught: ConnectException.\n\n\nCheck your internet connection. If your internet connection is fine,\n"
                    + "the most likely cause of this is a server outage.\n"
                            + "When many students are attempting to connect to the server at once,\n"
                            + "the server might go down. See the section of the assignment\n"
                            + "specification titled \"Reporting Outages\"\n\n", e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
