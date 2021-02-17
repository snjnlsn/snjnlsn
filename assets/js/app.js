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

console.log(document, window)
if ("MediaRecorder" in window) {
  // everything is good, let's go ahead
  alert("good")
} else {
  alert("bad")
}

const Hooks = {
  StartCamera: {
    mounted() {
      console.log(document, window)
      let hook = this
      const audio = this.el
      navigator.mediaDevices
        .getUserMedia({
          audio: true,
          video: false,
        })
        .then((stream) => {
          audio.srcObject = stream
          audio.onloadedmetadata = (e) => {
            audio.play()
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
  StartMemo: {
    mounted() {

      /* i have to figure out how to make his synchronous in order for it to work as a hook (which i think is the move? maybe not) */
      let hook = this;
      console.log('hello')
      const audio = this.el
      if ('MediaRecorder' in window) {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false})
        console.log(stream)
      }
    }
  }
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
