async function generateAI() {
  const file = document.getElementById("image").files[0];
  const status = document.getElementById("status");
  const video = document.getElementById("video");

  if (!file) {
    status.innerText = "Upload image first";
    return;
  }

  status.innerText = "Sending...";

  const formData = new FormData();
  formData.append("image", file);

  const res = await fetch("/api/music-video/generate", {
    method: "POST",
    body: formData
  });

  const data = await res.json();
  const jobId = data.jobId;

  check(jobId, status, video);
}

async function check(jobId, status, video) {
  const res = await fetch(`/api/music-video/status/${jobId}`);
  const data = await res.json();

  if (data.status === "complete") {
    status.innerText = "Done!";
    video.src = data.videoUrl;
    return;
  }

  status.innerText = "Processing...";
  setTimeout(() => check(jobId, status, video), 2000);
}
