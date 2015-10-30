package ssltest;

import java.net.URL;

public final class SSLTest {

	public static void main(final String[] args) {
		try {
			System.out.println("Testing SSL connection to https://registry.opensource.zalan.do/ui/ ...");
			final URL url = new URL("https://registry.opensource.zalan.do/ui/");
			url.openStream();
			System.out.println("No problems fetching the page! SSL seems to work.");
			System.exit(0);
		} catch (final Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
