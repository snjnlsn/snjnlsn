// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import { Socket } from "phoenix";
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import LiveSocket from "phoenix_live_view";
import socket from "./socket";

let channel = socket.channel("room:lobby", {});
let chatInput = document.querySelector("#chat-input");
let messagesContainer = document.querySelector("#messages");

// chatInput.addEventListener("keypress", (event) => {
//   if (event.keyCode === 13) {
//     channel.push("new_msg", { body: chatInput.value });
//     chatInput.value = "";
//   }
// });

// channel.on("new_msg", (payload) => {
//   const messageItem = document.createElement("li");
//   messageItem.innerText = `[${Date()}] ${payload.body}`;
//   messagesContainer.appendChild(messageItem);
// });

// channel
//   .join()
//   .receive("ok", (resp) => {})
//   .receive("error", (resp) => {
//     console.error("Unable to join", resp);
//   });

export default socket;

const renderRecording = (blob, list) => {
  const blobUrl = URL.createObjectURL(blob);
  const li = document.createElement("li");
  const audio = document.createElement("audio");
  const anchor = document.createElement("a");
  anchor.setAttribute("href", blobUrl);
  const now = new Date();
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
  );
  anchor.innerText = "Download";
  audio.setAttribute("src", blobUrl);
  audio.setAttribute("controls", "controls");
  li.appendChild(audio);
  li.appendChild(anchor);
  list.appendChild(li);
};

const setDocument = (message) =>
  (document.getElementById("errorMsg").innerText =
    document.getElementById("errorMsg").innerText + message);

const Hooks = {
  Songwriter: {
    mounted() {
      setDocument("mounted");
      const hook = this;
      if ("MediaRecorder" in window) {
        setDocument("it is");
      } else {
        setDocument("it not");
      }
      if ("MediaRecorder" in window) {
        const recordButton = document.getElementById("record"),
          mic = this.el,
          list = document.getElementById("recordings");
        mic.addEventListener("click", async () => {
          try {
            const mimeType = [
              // "audio/mp3",
              // "audio/mpeg",
              "audio/mp4",
              "audio/webm",
            ].filter(MediaRecorder.isTypeSupported)[0];
            setDocument(mimeType);
            const stream = await navigator.mediaDevices.getUserMedia({
              audio: {
                echoCancellation: false,
                noiseSuppression: false,
              },
              video: false,
            });
            let chunks = [],
              recording;
            const recorder = new MediaRecorder(stream);
            recorder.addEventListener("dataavailable", (event) => {
              if (typeof event.data === "undefined") return;
              if (event.data.size === 0) return;
              chunks.push(event.data);
            });
            recorder.addEventListener("stop", (event) => {
              recording = new Blob(chunks, {
                type: mimeType,
              });
              const reader = new FileReader();
              reader.onloadend = () =>
                hook.pushEvent("recieved", { data: reader.result, mimeType });
              reader.readAsDataURL(recording);
              renderRecording(recording, list);
              chunks = [];
            });
            recordButton.removeAttribute("hidden");
            recordButton.addEventListener("click", () => {
              if (recorder.state === "inactive") {
                recorder.start();
                recordButton.innerText = "Stop";
              } else {
                recorder.stop();
                // renderRecording(recording, list)
                recordButton.innerText = "Record";
              }
            });
          } catch (error) {
            console.log(error);
            this.pushEvent("cannot-record", { error }, (reply, _ref) =>
              console.log(reply)
            );
          }
        });
      } else {
        // this.pushEvent(
        //   "cannot-record",
        //   { error: "no mediaRecorder" },
        //   (reply, _ref) => console.log(reply)
        // )
      }
    },
    beforeUpdate() {
      setDocument("beforeUpdate");
    },
    updated() {
      setDocument("updated");
    },
    destroyed() {
      setDocument("destroyed");
    },
    disconnected() {
      setDocument("disconnected");
    },
    reconnected() {
      setDocument("reconnected");
    },
  },
};

const csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
const liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});
liveSocket.connect();
// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
