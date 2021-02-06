package com.banvien.tpk.core;


/**
 * Constant values used throughout the application.
 *
 */
public final class Constants {



    private Constants() {
        // hide me
    }
    //~ Static fields/initializers =============================================
    
    public static final String DATE_FORMAT = "MM/dd/yyyy";
    /**
     * The Alphabet number for search query
     */
    public static final String ALPHABET_SEARCH_PREFIX = "^$^";
    /**
     * The name of the ResourceBundle used in this application
     */
    public static final String BUNDLE_KEY = "ApplicationResources";

    /**
     * File separator from System properties
     */
    public static final String FILE_SEP = System.getProperty("file.separator");

    /**
     * User home from System properties
     */
    public static final String USER_HOME = System.getProperty("user.home") + FILE_SEP;

    /**
     * The name of the configuration hashmap stored in application scope.
     */
    public static final String CONFIG = "appConfig";

    /**
     * Session scope attribute that holds the locale set by the user. By setting this key
     * to the same one that Struts uses, we get synchronization in Struts w/o having
     * to do extra work or have two session-level variables.
     */
    public static final String PREFERRED_LOCALE_KEY = "org.apache.struts2.action.LOCALE";

    /**
     * The request scope attribute that holds the list form
     */
    public static final String LIST_MODEL_KEY = "items";
    
    /**
     * The request scope attribute that holds the form
     */
    public static final String FORM_MODEL_KEY = "item";
    

    /**
     * The name of the Administrator role, as specified in web.xml
     */
    public static final String ADMIN_ROLE = "ADMIN";
    public static final String NVKD_ROLE = "NHANVIENKD";
    public static final String NVTT_ROLE = "NHANVIENTT";
    public static final String NVKHO_ROLE = "NHANVIENKHO";
    public static final String TRUONGCA_ROLE = "TRUONGCA";

    public static final String QLKT_ROLE = "QUANLYKT";
    public static final String QLCN_ROLE = "QUANLYNO";


    public static final String QLKD_ROLE = "QUANLYKD";
    public static final String QLTT_ROLE = "QUANLYTT";
    public static final String QLKHO_ROLE = "QUANLYKHO";

    public static final String LANHDAO_ROLE = "LANHDAO";

    public static final String MODULE_XUAT_VT_SX = "XUAT_VT_SX";
    public static final String MODULE_XUAT_VT_BD = "XUAT_VT_BD";
    public static final String MODULE_NHAP_VT = "NHAP_VT";
    public static final String MODULE_XUAT_TD = "XUAT_TD";
    public static final String MODULE_NHAP_TD = "NHAP_TD";
    public static final String MODULE_NHAP_TP = "NHAP_TP";
    public static final String MODULE_XUAT_TP = "XUAT_TP";
    public static final String MODULE_GHI_SO = "GHI_SO";
    public static final String MODULE_MAY_THIET_BI = "MAY_THIET_BI";

    public static final String WAREHOSUE_PHUMY = "PHUMY";


    /**
     * The name of the user's role list, a request-scoped attribute
     * when adding/editing a user.
     */
    public static final String USER_ROLES = "userRoles";

    public static final Integer MIN_PERFORMANCE = 3;

    public static final Integer BONUS = 500000;

    /**
     * The name of the available roles list, a request-scoped attribute
     * when adding/editing a user.
     */
    public static final String AVAILABLE_ROLES = "availableRoles";

    /**
     * The name of the CSS Theme setting.
     */
    public static final String CSS_THEME = "csstheme";
    
    /**
     * Sort direction constants
     */
    public static final String SORT_ASC = "2";
    public static final String SORT_DESC = "1";

    /**
     * Acegi security constants
     */
    
    public static final String ACEGI_SECURITY_FORM_USERNAME_KEY = "j_username";
	public static final String ACEGI_SECURITY_FORM_PASSWORD_KEY = "j_password";

	public static final String ACEGI_SECURITY_LAST_USERNAME_KEY = "ACEGI_SECURITY_LAST_USERNAME";

    /**
     * Crudaction
     */
    public static final String ACTION_DELETE = "delete";
    public static final String ACTION_SEARCH = "search";
    public static final String ACTION_INSERT_UPDATE = "insert-update";
    public static final String ACTION_IMPORT = "import";
    public static final String ACTION_EXPORT = "export";

    public static final String MESSAGE_RESPONSE_MODEL_KEY = "messageResponse";

    public static final Integer TPK_USER_ACTIVE = 1;

    public static final Integer PRODUCE_LANH = 1;
    public static final Integer PRODUCE_MAU = 2;


    public static final Integer CUSTOMER_NORMAL = 1;
    public static final Integer CUSTOMER_WARNING = 0;

    public static final Integer MACHINE_NORMAL = 1;
    public static final Integer MACHINE_WARNING = 0;
    public static final Integer MACHINE_STOP = 2;
    public static final String POSTFIX_COMPONENT = "-MCGR";


    public static final String MATERIAL_GROUP_BUY = "BUY";
    public static final String MATERIAL_GROUP_MEASURE_LANH = "MEASURELANH";
    public static final String MATERIAL_GROUP_MEASURE_MAU = "MEASUREMAU";
    public static final String MATERIAL_GROUP_IMPORTED = "IMPORTED";

    public static final String PRODUCT_GROUP_BUY = "BUY";
    public static final String PRODUCT_GROUP_PRODUCED = "PRODUCED";
    public static final String PRODUCT_GROUP_IMPORTED = "IMPORTED";
    public static final String PRODUCT_GROUP_IMPORT_BACK = "IMPORT_BACK";
    public static final String PRODUCT_GROUP_RE_IMPORT = "RE_IMPORT";

    public static final String IMPORT_BACK_SUB_CODE = "-TN";



    public static final String PRODUCT_BLACK = "D";
    public static final String PRODUCT_LANH = "A";
    public static final String PRODUCT_KEM = "Z";
    public static final String PRODUCT_MAU = "M";
    public static final String PRODUCT_LANH_MAU = "LM";
    public static final String PRODUCT_KEM_MAU = "KM";
    public static final String PRODUCT_DEN_MAU = "DM";


    public static final String UNIT_MET = "m";
    public static final String UNIT_KG = "Kg";


    public static final Integer WAIT_CONFIRM = 0;
    public static final Integer CONFIRMED_MONEY = 3;
    public static final Integer REJECTED = 1;
    public static final Integer CONFIRMED = 2;
    public static final Integer CONFIRMED_TRANSFER = 4;
    public static final String INITIAL_IMPORT_CODE = "NDK-1";
    public static final String IMPORT_BACK_CODE = "TNK-1";


    //for booking
    public static final Integer BOOK_WAIT_CONFIRM = 1;
    public static final Integer BOOK_REJECTED = 10;
    public static final Integer BOOK_ALLOW_EXPORT = 20;
    public static final Integer BOOK_EXPORTING = 30;
    public static final Integer BOOK_EXPORTED = 40;


    public static final Integer ROOT_MATERIAL_STATUS_WAIT_CONFIRM = 0;
    public static final Integer ROOT_MATERIAL_STATUS_AVAILABLE = 1;
    public static final Integer ROOT_MATERIAL_STATUS_USED = 2;
    public static final Integer ROOT_MATERIAL_STATUS_EXPORTING = 3;
    public static final Integer ROOT_MATERIAL_STATUS_WAIT_TO_USE = 4;
    public static final Integer ROOT_MATERIAL_STATUS_BOOKED = 5;


    public static final String INITIAL_IMPORT_DATA = "Nhập đầu kỳ";
    public static final String IMPORT_BACK_DATA = "Tái nhập";


    public static final String EXPORT_TYPE_SAN_XUAT = "SX";
    public static final String EXPORT_TYPE_CHUYEN_KHO = "CK";
    public static final String EXPORT_TYPE_BAN = "BAN";
    public static final String EXPORT_TYPE_KHAC = "KHAC";
    public static final String EXPORT_TYPE_BTSC = "BTSC";

    public static final String CODE_NHAP_NOI_BO = "NNB";
    public static final String CODE_XUAT_NOI_BO = "XNB";
    public static final String CODE_XUAT_BAN_HANG = "XBH";
    public static final String CODE_XUAT_KHAC = "XKH";

    public static final String PRODUCT_MA_LANH_CODE = "A";

    public static final Long A_DAY = 3600000L*24;
    public static final Long THREE_DAY = 3600000L*24*3;
    public static final Long A_WEEK = 3600000L*24*7;
    public static final Long A_MONTH = 3600000L*24*30;
    public static final Long A_YEAR = 3600000L*24*365;


    public static final String QUALITY_A = "A";
    public static final String QUALITY_B = "B";
    public static final String QUALITY_C = "C";
    public static final String QUALITY_PP = "PP";

    public static final String PNK_PREFIX = "PNK-";
    public static final String PTN_PREFIX = "TNK-";

    public static final String PXK_PREFIX = "PXK-";
    public static final String TON = "TÔN";
    public static final String MAU = "MÀU";
    public static final String OWE_PLUS = "PLUS";
    public static final String OWE_MINUS = "MINUS";

    public static final Double SPECIAL_WEIGHT = 7.85d;



    public static final Integer MACHINE_REJECTED = 10;
    public static final Integer MACHINE_SUBMIT = 20;
    public static final Integer MACHINE_APPROVED_1 = 30;
    public static final Integer MACHINE_APPROVED_2 = 40;

    public static final String M_CATE_MAU = "PL-MAU";

    public static final String PRODUCT_LEVEL_1 = "PRODUCT_LEVEL_1";
    public static final String PRODUCT_LEVEL_2 = "PRODUCT_LEVEL_2";
    public static final String PRODUCT_LEVEL_3 = "PRODUCT_LEVEL_3";

    public static final String SETTING_DEFAULT_BANK_ACCOUNT = "default.bank.account";

    public static final String SETTING_PRICE_TYPE_C = "price.type.c";




}