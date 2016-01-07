import com.banvien.tpk.security.DesEncrypterUtils;
import junit.framework.TestCase;


public class DesEncrypterUtilsTest extends TestCase {
    public void testEncrypt() {
        System.out.println(DesEncrypterUtils.getInstance().encrypt("123456"));
    }
}
