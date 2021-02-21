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

function renderError(message) {
  const wrapper = document.getElementById("errorMsg")
  wrapper.innerHTML = `<div class="error"><p>${message}</p></div>`
}

function renderRecording(blob, list) {
  const blobUrl = URL.createObjectURL(blob)
  const li = document.createElement("li")
  const audio = document.createElement("audio")
  const anchor = document.createElement("a")
  anchor.setAttribute("href", blobUrl)
  const now = new Date()
  anchor.setAttribute(
    "download",
    `recording-${now.getFullYear()}-${(now.getMonth() + 1)
      .toString()
      .padStart(2, "0")}-${now
      .getDay()
      .toString()
      .padStart(2, "0")}--${now
      .getHours()
      .toString()
      .padStart(2, "0")}-${now
      .getMinutes()
      .toString()
      .padStart(2, "0")}-${now.getSeconds().toString().padStart(2, "0")}.webm`
  )
  anchor.innerText = "Download"
  audio.setAttribute("src", blobUrl)
  audio.setAttribute("controls", "controls")
  li.appendChild(audio)
  li.appendChild(anchor)
  list.appendChild(li)
}

const mic = document.getElementById("mic")

let audioCtx, audioNode
if ("MediaRecorder" in window && mic) {
  const recordButton = document.getElementById("record"),
    list = document.getElementById("recordings"),
    codeBlock = document.getElementById("code-block")

  mic.addEventListener("click", async () => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          sampleRate: 48000,
          echoCancellation: false,
          noiseSuppression: false,
        },
        video: false,
      })
      const mimeType = "audio/aac"
      const chunks = []
      const recorder = new MediaRecorder(stream, {
        type: mimeType,
      })
      recorder.addEventListener("dataavailable", (event) => {
        if (typeof event.data === "undefined") return
        if (event.data.size === 0) return
        chunks.push(event.data)
      })
      recorder.addEventListener("stop", () => {
        const recording = new Blob(chunks, {
          type: mimeType,
        })
        renderRecording(recording, list)
        chunks = []
      })
      recordButton.removeAttribute("hidden")
      recordButton.addEventListener("click", () => {
        if (recorder.state === "inactive") {
          recorder.start()
          recordButton.innerText = "Stop"
        } else {
          recorder.stop()
          renderRecording(recording, list)
          recordButton.innerText = "Record"
        }
      })
      // codeBlock.innerHTML = stream
    } catch {
      renderError(
        "You denied access to the microphone so this demo will not work."
      )
    }
  })
} else {
  alert("bad")
}

const Hooks = {
  StartCamera: {
    mounted() {
      // console.log(document, window)
      // let hook = this
      // const audio = this.el
      // navigator.mediaDevices
      //   .getUserMedia({
      //     audio: true,
      //     video: false,
      //   })
      //   .then((stream) => {
      //     audio.srcObject = stream
      //     audio.onloadedmetadata = (e) => {
      //       audio.play()
      //       const mediaRecorder = new MediaRecorder(stream, {
      //         mimeType: "video/webm",
      //         videoBitsPerSecond: 3000000,
      //       })
      //       mediaRecorder.ondataavailable = (e) => {
      //         const reader = new FileReader()
      //         reader.onloadend = () => {
      //           hook.pushEvent("video_data", { data: reader.result })
      //         }
      //         reader.readAsDataURL(e.data)
      //       }
      //       mediaRecorder.start(1000)
      //     }
      //   })
    },
  },
  StartMemo: {
    mounted() {
      /* i have to figure out how to make his synchronous in order for it to work as a hook (which i think is the move? maybe not) */
      //   let hook = this;
      //   console.log('hello')
      //   const audio = this.el
      //   if ('MediaRecorder' in window) {
      //     const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false})
      //     console.log(stream)
      //   }
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
