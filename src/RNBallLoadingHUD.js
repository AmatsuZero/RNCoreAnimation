import { NativeModules } from 'react-native'
const LoadingHUD = NativeModules.JZHLoadingHUD
export default class {
    static showHUD() {
        LoadingHUD.showHUD()
    }
    static dismissHUD() {
        LoadingHUD.dismissHUD()
    }
}
