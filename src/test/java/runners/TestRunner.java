package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import java.util.List;


public class TestRunner {

    private static final int THREAD_COUNT = 5;

    // Method to dynamically retrieve tags
    private String getTags() {
        return System.getProperty("karate.tags", "@Regression");
    }

    @Test
    public void runTest() {
        // Instantiate FeaturePathReader to get features
        FeaturePathReader pathReader = new FeaturePathReader();
        List<String> featurePaths = pathReader.getFeaturePaths();
        String tags = getTags();

        Results results = Runner.path(featurePaths)
                .tags(tags)
                .parallel(THREAD_COUNT);

        // Assert if there are any failed scenarios
        Assertions.assertEquals(0, results.getFailCount(), "There are scenario failures");
    }
}
