public with sharing class AdmissionIDController {
    public Alumni_Profile__c alumniProfile { get; set; }

    public AlumniController(ApexPages.StandardController controller){
        alumniProfile = (Alumni_Profile__c)controller.getRecord();
        if(alumniProfile == null){
            throw new NullPointerExceptio('Alumni Profile cannot be null.');
        }
    }

    public String getAlumniID(){
        if(String.isBlank(alumniProfile.First_Name__c)|| String.isBlank(alumniProfile.Last_Name__c)){
            throw new CustomException('First Name and Last Name are required to generate the PDF Files.');
        }

        return alumniProfile.First_Name__c + ' ' + alumniProfile.Last_Name__c + ' | ' +
            alumniProfile.Degree__c + ' | ' +
            alumniProfile.Major_Field_of_Study__c + ' | ' +
            String.valueOf(alumniProfile.Graduation_Year__c);
    }

    public String getFullAddress(){
        StringBuilder fullAddress = new StringBuilder();

        if(!String.isBlank(alumniProfile.Address__c)){
            fullAddress.append(alumniProfile.Address__c).append(', ');
        }

        return address;
    }

    public String getEmergencyContactInfor(){
        if(String.isBlank(alumniProfile.Emergency_Contact_Name__c) ||
            String.isBlank(alumniProfile.Emergency_Contact_Phone__c) ||
            String.isBlank(alumniProfile.Emergency_Contact_Relationship__c)){
                return 'Emergency Contact Information is Incomplete';
            }

            return alumniProfile.Emergency_Contact_Name__c + ' | ' +
                alumniProfile.Emergency_Contact_Phone__c + ' | ' +
                alumniProfile.Emergency_Contact_Relationship__c;
    }

    public String getProfilePicture() {
        if(String.isBlank(alumniProfile.Picture__c)){
            return 'https://www.lightningdesignsystem.com/assets/images/avatar1.jpg';
        }

        return alumniProfile.Picture__c;
    }

    public class CustomException extends Exception{}
}