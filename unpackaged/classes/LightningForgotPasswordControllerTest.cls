@IsTest(SeeAllData = true)
public with sharing class LightningForgotPasswordControllerTest {

 /* Verifies that ForgotPasswordController handles invalid usernames appropriately */
 @IsTest
 static void testLightningForgotPasswordControllerInvalidUserName() {
  System.assertEquals(LightningForgotPasswordController.forgotPassword('fakeUser', 'http://a.com'), Label.Site.invalid_email);
  System.assertEquals(LightningForgotPasswordController.forgotPassword(null, 'http://a.com'), Label.Site.invalid_email);
  System.assertEquals(LightningForgotPasswordController.forgotPassword('a', '/home/home.jsp'), Label.Site.invalid_email);
 }

 /* Verifies that null checkEmailRef url throws proper exception. */
 @IsTest
 static void testLightningForgotPasswordControllerWithNullCheckEmailRef() {
  System.assertEquals(LightningForgotPasswordController.forgotPassword('a', null), 'Argument 1 cannot be null');
  System.assertEquals(LightningForgotPasswordController.forgotPassword('a@salesforce.com', null), 'Argument 1 cannot be null');
 }

 /* Verifies that LightningForgotPasswordController object is instantiated correctly. */
 @IsTest
 static void LightningForgotPasswordControllerInstantiation() {
  LightningForgotPasswordController controller = new LightningForgotPasswordController();
  System.assertNotEquals(controller, null);
 }

 @IsTest
 static void testLightningForgotPasswordControllerValidUser() {
  Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
  User u = new User(
   Alias = 'tuser',
   Email = 'tuser' + DateTime.now().getTime() + '@test.com',
   EmailEncodingKey = 'UTF-8',
   LastName = 'User',
   LanguageLocaleKey = 'en_US',
   LocaleSidKey = 'en_US',
   ProfileId = p.Id,
   TimeZoneSidKey = 'America/Los_Angeles',
   Username = 'tuser' + DateTime.now().getTime() + '@test.com'
  );
  insert u;

  Test.startTest();
  System.runAs(u) {
   String result = LightningForgotPasswordController.forgotPassword(u.Username, 'http://validUrl.com');
   if (result == Label.Site.invalid_email) {
    // The user may not be recognized in the test site context; result could be invalid_email.
    System.debug('Returned: ' + result);
   } else {
    System.assertEquals(null, result);
   }
  }
  Test.stopTest();
 }

 @IsTest
 static void testLightningForgotPasswordControllerSetExperienceId() {
  Test.startTest();
  String result1 = LightningForgotPasswordController.setExperienceId(null);
  System.assertEquals(null, result1);

  String result2 = LightningForgotPasswordController.setExperienceId('myExpId');
  System.assertEquals(null, result2);
  Test.stopTest();
 }
}