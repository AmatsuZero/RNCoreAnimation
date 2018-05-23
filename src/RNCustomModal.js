import {
    Modal
} from "react-native"
import PropTypes from "prop-types"

Modal.propTypes = Object.assign(Modal.propTypes, {
    useCustomDelegate: PropTypes.bool
})

Modal.defaultProps = Object.assign(Modal.defaultProps, {
    useCustomDelegate: false
})

export default () => {

}
