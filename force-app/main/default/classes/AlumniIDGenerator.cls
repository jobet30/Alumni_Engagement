public with sharing class AlumniIDGenerator {

    public class AlumniProfileWrapper {
        @InvocableVariable(label='Alumni Profile ID')
        public Id AlumniProfileId;
    }

    @InvocableMethod(label='Generate Alumni ID PDF')
    public static List<Blob> generateAlumniIDPDF(List<AlumniProfileWrapper> alumniProfiles) {
        List<Blob> pdf = new List<Blob>();
        Set<Id> alumniProfileIds = new Set<Id>();

        for (AlumniProfileWrapper wrapper : alumniProfiles) {
            alumniProfileIds.add(wrapper.AlumniProfileId);
        }

        List<Alumni_Profile__c> alumniProfileList = [SELECT
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
            FROM Alumni_Profile__c
            WHERE Id IN :alumniProfileIds
        ];

        for (Alumni_Profile__c alumniProfile : alumniProfileList) {
            String pdfContent = generatePDFContent(alumniProfile);
            Blob pdfBlob = Blob.toPdf(pdfContent);
            pdf.add(pdfBlob);
        }

        return pdf;
    }

    private static String generatePDFContent(Alumni_Profile__c alumniProfile) {
        String content = '';
        content += 'First Name: ' + alumniProfile.First_Name__c + '\n';
        content += 'Last Name: ' + alumniProfile.Last_Name__c + '\n';
        content += 'Email: ' + alumniProfile.Email__c + '\n';
        content += 'Date of Birth: ' + alumniProfile.Date_Of_Birth__c + '\n';
        content += 'Gender: ' + alumniProfile.Gender__c + '\n';
        content += 'Emergency Contact Name: ' + alumniProfile.Emergency_Contact_Name__c + '\n';
        content += 'Emergency Contact Relations: ' + alumniProfile.Emergency_Contact_Relationship__c + '\n';
        content += 'Emergency Contact Phone: ' + alumniProfile.Emergency_Contact_Phone__c + '\n';
        content += 'Emergency Contact Address: ' + alumniProfile.Emergency_Contact_Address__c + '\n';
        return content;

    }
}
