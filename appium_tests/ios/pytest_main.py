import time
import pytest
from appium import webdriver
from appium.options.ios import XCUITestOptions
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


capabilities = dict(
    platformName='iOS',
    automationName='XCUITest',
    deviceName='iPhone 15 Pro',
    platformVersion='17.4',
    app='com.thinkresearch.app'
)

# appium_server_url = 'http://hub.browserstack.com/wd/hub'
appium_server_url = 'http://localhost:4723'

@pytest.fixture(scope="function")
def driver(request):
    options = XCUITestOptions().load_capabilities(capabilities)
    driver = webdriver.Remote(appium_server_url, options=options)
    yield driver
    driver.quit()


BUTTON_BACK = (AppiumBy.XPATH, "//XCUIElementTypeApplication[@name=\"ThinkResearch Chatbot\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeButton[1]")
BUTTON_SELECT_SURVEY = (AppiumBy.ACCESSIBILITY_ID, "Survey")
BUTTON_FAB = (AppiumBy.XPATH, "//XCUIElementTypeButton")
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
INPUT_FIELD = (AppiumBy.ACCESSIBILITY_ID, "Type your message...")
SEND_MSG = (AppiumBy.XPATH, "//XCUIElementTypeApplication[@name=\"ThinkResearch Chatbot\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeButton")
OPTION_CLOSE = (AppiumBy.XPATH, "//XCUIElementTypeStaticText[@name=\"Close\"]")
MESSAGE_ASSIGNED_TO = (AppiumBy.XPATH, "//XCUIElementTypeStaticText[contains(@name, \"Assigned to\")]")


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

    def test_new_conversation(self):
        self.click(BUTTON_FAB)
        self.assert_visible(BUTTON_NEED_CARE)
    
    # def test_formatted_msg(self):
    #     self.click(BUTTON_FAB)
    #     self.assert_visible(BUTTON_NEED_CARE)
    #     self.click(BUTTON_BACK)
    #     self.click(BUTTON_NEW_CONVO)
    #     self.click(BUTTON_SELECT_OPTION)
    #     self.click(OPTION_FORMATTED_MSG)
    #     self.click(BUTTON_SEND)
    #     self.assert_visible(OPTION_BACK)

    # def test_survey(self):
    #     self.click(BUTTON_FAB)
    #     self.assert_visible(BUTTON_NEED_CARE)
    #     self.click(BUTTON_BACK)
    #     self.click(BUTTON_NEW_CONVO)
    #     self.click(BUTTON_SELECT_OPTION)
    #     self.click(BUTTON_SELECT_SURVEY)
    #     self.click(BUTTON_SEND)
    #     self.assert_visible(BUTTON_START_SURVEY)
        
    # def test_enter_input(self):
    #     self.click(BUTTON_FAB)
    #     self.assert_visible(BUTTON_NEED_CARE)
    #     self.click(BUTTON_BACK)
    #     self.click(BUTTON_NEW_CONVO)
    #     self.click(BUTTON_SELECT_OPTION)
    #     self.click(OPTION_ENTER_INPUT)
    #     self.click(BUTTON_SEND)
    #     self.click(INPUT_FIELD)
    #     input_field = self.driver.find_element(*INPUT_FIELD)
    #     input_field.send_keys("hello")
    #     self.click(SEND_MSG)
    #     self.assert_visible(OPTION_CLOSE)
    
    # def test_assign_agent(self):
    #     self.click(BUTTON_FAB)
    #     self.assert_visible(BUTTON_NEED_CARE)
    #     self.click(BUTTON_BACK)
    #     self.click(BUTTON_NEW_CONVO)
    #     self.click(BUTTON_SELECT_OPTION)
    #     self.click(OPTION_ASSIGN_AGENT)
    #     self.click(BUTTON_SEND)
    #     self.assert_visible(MESSAGE_ASSIGNED_TO)