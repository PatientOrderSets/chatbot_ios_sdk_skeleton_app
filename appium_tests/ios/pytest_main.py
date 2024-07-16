import time
import pytest
from appium import webdriver
from appium.options.ios import XCUITestOptions
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains


capabilities = dict(
    platformName='iOS',
    automationName='XCUITest',
    deviceName='iPhone 15 Pro',
    platformVersion='17.4',
    app='com.thinkresearch.app'
)

app_config = dict(
    apiKey='${apiKey}',
    serverURL='${serverURL}'
)

appium_server_url = 'http://localhost:4723'

@pytest.fixture(scope="function")
def driver(request):
    options = XCUITestOptions().load_capabilities(capabilities)
    driver = webdriver.Remote(appium_server_url, options=options)
    yield driver
    driver.quit()


BUTTON_BACK = (AppiumBy.XPATH, "//XCUIElementTypeApplication[@name=\"ThinkResearch Chatbot\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeButton[1]")
BUTTON_SELECT_SURVEY = (AppiumBy.ACCESSIBILITY_ID, "Survey")
BUTTON_FAB = (AppiumBy.XPATH, "//XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[3]")
BUTTON_NEW_CONVO = (AppiumBy.ACCESSIBILITY_ID, "Start a conversation")
BUTTON_SELECT_OPTION = (AppiumBy.ACCESSIBILITY_ID, "Select an option")
BUTTON_SEND = (AppiumBy.XPATH, "//XCUIElementTypeApplication[@name=\"ThinkResearch Chatbot\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeButton[3]")
BUTTON_NEED_CARE = (AppiumBy.ACCESSIBILITY_ID, "I need care")
BUTTON_START_SURVEY = (AppiumBy.ACCESSIBILITY_ID, "Start")
OPTION_FORMATTED_MSG = (AppiumBy.XPATH, "//XCUIElementTypeButton[@name=\"Formatted Messages\"]")
OPTION_SURVEY = (AppiumBy.XPATH, "//XCUIElementTypeButton[@name=\"Survey\"]")
OPTION_ENTER_INPUT = (AppiumBy.XPATH, "//XCUIElementTypeButton[@name=\"Enter input\"]")
OPTION_ASSIGN_AGENT = (AppiumBy.XPATH, "//XCUIElementTypeButton[@name=\"Assign to agent\"]")
OPTION_BACK = (AppiumBy.XPATH, "//XCUIElementTypeStaticText[@name=\"Back\"]")
OPTION_CANCEL = (AppiumBy.XPATH, "//*[contains(@name, 'Cancel') or contains(text(), 'Cancel')]")
INPUT_FIELD = (AppiumBy.ACCESSIBILITY_ID, "Type your message...")
SEND_MSG = (AppiumBy.XPATH, "//XCUIElementTypeApplication[@name=\"ThinkResearch Chatbot\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeButton")
OPTION_CLOSE = (AppiumBy.XPATH, "//XCUIElementTypeStaticText[@name=\"Close\"]")
MESSAGE_ASSIGNED_TO = (AppiumBy.XPATH, "//XCUIElementTypeStaticText[contains(@name, \"Assigned to\")]")

BUTTON_SETTINGS =  (AppiumBy.XPATH, "//XCUIElementTypeStaticText[@name=\"Settings\"]")
SETTINGS_PRESET =   (AppiumBy.XPATH, "//XCUIElementTypeScrollView/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeTextField")
SETTINGS_SELECT_PROD = (AppiumBy.XPATH, "//XCUIElementTypePickerWheel[@value=\"Other\"] ")
SETTINGS_BUTTON_SAVE = (AppiumBy.XPATH, "//XCUIElementTypeStaticText[@name=\"Save\"]")
SETTINGS_TOGGLE = (AppiumBy.XPATH, "//XCUIElementTypeSwitch")
SETTINGS_BUTTON_BACK = (AppiumBy.ACCESSIBILITY_ID, "Back")
SETTINGS_APP_ID = (AppiumBy.XPATH, "(//XCUIElementTypeTextField)[2]")
SETTINGS_ORIGIN = (AppiumBy.XPATH, "(//XCUIElementTypeTextField)[3]")
SETTINGS_BASE_URL = (AppiumBy.XPATH, "(//XCUIElementTypeTextField)[4]")
SETTINGS_SELECT_LANGUAGE = (AppiumBy.XPATH, "(//XCUIElementTypeTextField)[5]")


class TestAppium:
    @pytest.fixture(autouse=True)
    def set_up(self, driver):
        self.driver = driver
        self.wait = WebDriverWait(self.driver, 10)
        
    def click(self, locator):
        element = self.wait.until(EC.presence_of_element_located(locator))
        element.click()
    
    def assert_visible(self, locator):
        element = self.wait.until(EC.presence_of_element_located(locator))
        assert element.is_displayed()

    def tap_by_coordinates(self, x, y):
        action = self.driver.create_webdriver_action()
        action.pointer_action.pointer_down(x, y)
        action.pointer_action.pointer_up()
        action.perform()

    def select_settings(self):
        self.click(BUTTON_SETTINGS)
        self.click(SETTINGS_PRESET)
        self.click(SETTINGS_SELECT_PROD)
        element = self.wait.until(EC.presence_of_element_located(SETTINGS_SELECT_PROD))
        element.send_keys("Production")
        self.click(SETTINGS_BUTTON_SAVE)
        self.click(SETTINGS_TOGGLE)
        self.click(SETTINGS_BUTTON_BACK)

    def enter_settings(self):
        self.click(BUTTON_SETTINGS)

        input_box = self.wait.until(EC.presence_of_element_located(SETTINGS_APP_ID))
        input_box.send_keys(app_config['apiKey'])

        input_box = self.wait.until(EC.presence_of_element_located(SETTINGS_ORIGIN))
        input_box.send_keys(app_config['serverURL'])

        input_box = self.wait.until(EC.presence_of_element_located(SETTINGS_BASE_URL))
        input_box.send_keys(app_config['serverURL'])

        self.click(SETTINGS_SELECT_LANGUAGE)
        element = self.wait.until(EC.presence_of_element_located(SETTINGS_SELECT_LANGUAGE))
        element.send_keys("en")

        self.click(SETTINGS_BUTTON_SAVE)
        self.click(SETTINGS_TOGGLE)
        self.click(SETTINGS_BUTTON_BACK)

    def test_smoke(self):
        self.assert_visible(BUTTON_FAB)

    def test_settings(self):
        self.click(BUTTON_SETTINGS)
        self.assert_visible(SETTINGS_BUTTON_SAVE)

    def test_save_settings(self):
        self.enter_settings()
        self.assert_visible(BUTTON_FAB)

    def test_new_conversation(self):
        self.enter_settings()
        self.click(BUTTON_FAB)
        self.assert_visible(BUTTON_SELECT_OPTION)

    def test_option_list(self):
        self.enter_settings()
        self.click(BUTTON_FAB)
        self.click(BUTTON_SELECT_OPTION)
        self.assert_visible(OPTION_CANCEL)
