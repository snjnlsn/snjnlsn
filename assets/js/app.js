// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import { Socket } from "phoenix"
import LiveSocket from "phoenix_live_view"

const Hooks = {
  StartCamera: {
    mounted() {
      let hook = this
      const video = this.el
      navigator.mediaDevices
        .getUserMedia({
          audio: true,
          video: true,
        })
        .then((stream) => {
          video.srcObject = stream
          video.onloadedmetadata = (e) => {
            video.play()
            const mediaRecorder = new MediaRecorder(stream, {
              mimeType: "video/webm",
              videoBitsPerSecond: 3000000,
            })
            mediaRecorder.ondataavailable = (e) => {
              const reader = new FileReader()
              reader.onloadend = () => {
                hook.pushEvent("video_data", { data: reader.result })
              }
              reader.readAsDataURL(e.data)
            }
            mediaRecorder.start(1000)
          }
        })
    },
  },
}

const csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
})
liveSocket.connect()
// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
