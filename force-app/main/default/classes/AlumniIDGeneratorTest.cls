/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AlumniIDGeneratorTest {

    @isTest
    public static void testGenerateAlumniIDPDF() {
        Alumni_Profile__c alumniProfile = new Alumni_Profile__c();
        alumniProfile.First_Name__c = 'Jobet';
        alumniProfile.Last_Name__c = 'Casquejo';
        alumniProfile.Email__c = 'jobet@gmail.com';
        alumniProfile.Date_Of_Birth__c = Date.newInstance(2000, 1, 1);
        alumniProfile.Gender__c = 'Male';
        alumniProfile.Emergency_Contact_Name__c = 'Jane Doe';
        alumniProfile.Emergency_Contact_Relationship__c = 'Family Member';
        alumniProfile.Emergency_Contact_Phone__c = '9876543210';
        alumniProfile.Emergency_Contact_Address__c = 'Misamis Occidental';

        insert alumniProfile;

        AlumniIDGenerator.AlumniProfileWrapper wrapper = new AlumniIDGenerator.AlumniProfileWrapper();
        wrapper.AlumniProfileId = alumniProfile.Id;

        Test.startTest();
        List<Blob> pdf = AlumniIDGenerator.generateAlumniIDPDF(new List<AlumniIDGenerator.AlumniProfileWrapper> { wrapper });
        Test.stopTest();

        List<Alumni_Profile__c> alumniProfiles = [
            SELECT 
                Id, 
                First_Name__c, 
                Last_Name__c, 
                Email__c, 
                Date_Of_Birth__c, 
                Gender__c,
                Emergency_Contact_Name__c,
                Emergency_Contact_Relationship__c,
                Emergency_Contact_Phone__c,
                Emergency_Contact_Address__c
            FROM Alumni_Profile__c WHERE Id =: alumniProfile.Id
            ];

        Assert.areEqual(1, pdf.size(), 'Wrong number of PDF');
        Assert.areEqual(1, alumniProfiles.size(), 'Wrong number of records');
        Assert.areEqual(alumniProfile.Id, alumniProfiles[0].Id, 'Wrong record');
    }
}