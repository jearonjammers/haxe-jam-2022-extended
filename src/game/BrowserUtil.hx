package game;

import js.Browser;

class BrowserUtil {
    public static function isMobile() : Bool {
        return ~/iPhone|iPad|iPod|Android/i.match(Browser.navigator.userAgent);
    }
}