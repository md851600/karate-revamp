package runners;

import java.util.ArrayList;
import java.util.List;

public class FeaturePathReader {

    private List<String> featurePaths;

    // Constructor to initialize the featurePaths list
    public FeaturePathReader() {
        this.featurePaths = new ArrayList<>();
        loadFeaturePaths();
    }

    // Method to load feature into the list
    private void loadFeaturePaths() {
        featurePaths.add("classpath:features/tokens/GenerateOperatorToken.feature");
        featurePaths.add("classpath:features/tokens/GenerateSupervisorToken.feature");
        featurePaths.add("classpath:features/accounts/Account.feature");
        featurePaths.add("classpath:features/accounts/GetAccounts.feature");
        featurePaths.add("classpath:features/accounts/CreateAccount.feature");
        featurePaths.add("classpath:features/accounts/CreateAccountWithRandomEmail.feature");
        featurePaths.add("classpath:features/accounts/CreateAndDeleteAccount.feature");
        featurePaths.add("classpath:features/accounts/DeleteAccount.feature");
        featurePaths.add("classpath:features/plans/PlanCode.feature");
        featurePaths.add("classpath:features/security/SecurityTest.feature");
    }

    // Public getter method to return the features
    public List<String> getFeaturePaths() {
        return featurePaths;
    }

    public void setFeaturePaths(List<String> featurePaths) {
        this.featurePaths = featurePaths;
    }
}

