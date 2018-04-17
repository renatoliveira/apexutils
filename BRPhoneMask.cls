/**
 * A class that is used to format phone numbers to a standard brazilian format.
 * (99) 99999-9999
 */
global class BRPhoneMask {

    /**
     * Create mask based on the account phone number.
     *
     * @param records Account records
     */
    global static void createPhoneMasks (List<Account> records) {
        for (Account record : records) {
            if (record.PersonMobilePhone.isAlphanumeric() && isValidPhoneLength(record.PersonMobilePhone)) {
                record.PersonMobilePhone = createPhoneMask(record.PersonMobilePhone);
            }
            if (record.PersonHomePhone.isAlphanumeric() && isValidPhoneLength(record.PersonHomePhone)) {
                record.PersonHomePhone = createPhoneMask(record.PersonHomePhone);
            }
            if (record.Phone.isAlphanumeric() && isValidPhoneLength(record.Phone)) {
                record.Phone = createPhoneMask(record.Phone);
            }
            if (record.PersonOtherPhone.isAlphanumeric() && isValidPhoneLength(record.PersonOtherPhone)) {
                record.PersonOtherPhone = createPhoneMask(record.PersonOtherPhone);
            }
        }
    }

    /**
     * Create the mask, based on the phone number provided.
     */
    global static String createPhoneMask(String phoneNumberAsString) {
        if (phoneNumberAsString.length() == 10) {
            return String.format('({0}) {1}-{2}', new List<String>{
                phoneNumberAsString.substring(0,2),
                phoneNumberAsString.substring(2,6),
                phoneNumberAsString.substring(6,10)
            });
        } else if (phoneNumberAsString.length() == 11) {
            return String.format('({0}) {1}-{2}', new List<String>{
                phoneNumberAsString.substring(0,2),
                phoneNumberAsString.substring(2,7),
                phoneNumberAsString.substring(7,11)
            });
        }
        return '';
    }

    /**
     * Valid phone numbers should have either 10 or 11 digits.
     */
    private static Boolean isValidPhoneLength (String phone) {
        if (phone == null) {
            return false;
        }
        Integer len = phone.replaceAll('\\D', '').length();
        if (len == 10 || len == 11) {
            return true;
        }
        return false;
    }
}