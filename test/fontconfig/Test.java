import java.awt.*;
import java.io.*;

public class Test {
	public static void main(String... argz) throws Exception {
		boolean headless = GraphicsEnvironment.getLocalGraphicsEnvironment().isHeadless();
		System.out.println(String.format("Headless: %s", headless));
		Font.createFont(Font.TRUETYPE_FONT, new File("test.ttf")).deriveFont(Font.TRUETYPE_FONT, 20F);
	}
}
