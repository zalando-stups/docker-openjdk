package catest;

import java.net.URL;

public final class CATest {

	public static void main(final String[] args) {
		try {
			System.out.println("Testing SSL connection to https://stash.zalando.net/projects ...");
			final URL url = new URL("https://stash.zalando.net/projects");
			url.openStream();
			System.out.println("No problems fetching the page! SSL seems to work.");
			System.exit(0);
		} catch (final Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
