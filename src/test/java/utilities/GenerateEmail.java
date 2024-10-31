package utilities;

public abstract class GenerateEmail {

    public static String generateRandomEmail() {
        int random = (int) (Math.random() * 100000000);
        return "test" + random + "@tekSchool.us";
    }

}
