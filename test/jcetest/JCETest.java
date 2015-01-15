package jcetest;

import javax.crypto.Cipher;
import java.security.KeyPairGenerator;
import java.security.Provider;
import java.security.Security;
import java.util.HashSet;
import java.util.Set;

public final class JCETest {

	public static void main(final String[] args) throws Exception {
		final Set<String> requiredAlgorithms = new HashSet<String>() {{
			add("RSA");
			add("EC");
		}};
		for (Provider provider : Security.getProviders()) {
			for (Provider.Service service : provider.getServices()) {
				if ("KeyPairGenerator".equals(service.getType())) {
					System.out.println("Algorithm: " + service.getAlgorithm() + " (" + service.getType() + " @ " + provider.getName() + ")");
					KeyPairGenerator.getInstance(service.getAlgorithm(), provider.getName());
					requiredAlgorithms.remove(service.getAlgorithm());
				}
			}
		}
		if (!requiredAlgorithms.isEmpty()) {
			System.out.println("Required algorithms not found: " + requiredAlgorithms);
			System.exit(1);
		}

		final String keyAlgorithm = "EC";
		final int restrictedKeySize = 128;

		final int maxKeySize = Cipher.getMaxAllowedKeyLength(keyAlgorithm);
		System.out.println("Maximum " + keyAlgorithm + " keysize: " + maxKeySize + " (restricted is " + restrictedKeySize + ")");

		if (maxKeySize <= restrictedKeySize) {
			System.exit(1);
		}
	}
}
