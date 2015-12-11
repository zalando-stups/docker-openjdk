package catest;

import java.net.URL;

public final class CATest {

	public static void main(final String[] args) {
		try {
			System.out.println("Testing SSL connection to https://ssl-test.stups-test.zalan.do/ ...");
			final URL url = new URL("https://ssl-test.stups-test.zalan.do/");
			url.openStream();
			System.out.println("No problems fetching the page! SSL seems to work.");
			System.exit(0);
        } catch (final java.io.IOException e) {
            if (e.getMessage().startsWith("Server returned HTTP response code: 503")) {
                System.out.println("No problems with SSL cert (server returned 503)! SSL seems to work.");
                System.exit(0);
            } else {
                e.printStackTrace();
                System.exit(1);
            }
		} catch (final Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
