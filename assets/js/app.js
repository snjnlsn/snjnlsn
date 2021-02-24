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

const renderRecording = (blob, list) => {
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

const Hooks = {
  VoiceMemo: {
    mounted() {
      const hook = this
      this.handleEvent("record", (payload) =>
        console.log(payload, "hey we got this cliqqq")
      )
      if ("MediaRecorder" in window) {
        const recordButton = document.getElementById("record"),
          mic = this.el,
          list = document.getElementById("recordings")

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
            let chunks = []
            const recorder = new MediaRecorder(stream, {
              type: mimeType,
            })
            recorder.addEventListener("dataavailable", (event) => {
              if (typeof event.data === "undefined") return
              if (event.data.size === 0) return
              const reader = new FileReader()
              reader.onloadend = () =>
                hook.pushEvent("recieved", { data: reader.result })
              reader.readAsDataURL(event.data)
              chunks.push(event.data)
            })
            recorder.addEventListener("stop", () => {
              const recording = new Blob(chunks, {
                type: mimeType,
              })
              hook.pushEvent("done", { data: recording })
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
          } catch (error) {
            this.pushEvent("cannot-record", { error }, (reply, _ref) =>
              console.log(reply)
            )
          }
        })
      } else {
        this.pushEvent(
          "cannot-record",
          { error: "no mediaRecorder" },
          (reply, _ref) => console.log(reply)
        )
        alert("bad")
      }
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
