const titleEl = document.querySelector("title");
const codeEl = document.querySelector("pre");

const favicon = document.querySelector("link[rel=icon]");
const canvas = document.createElement("canvas");
const ctx = canvas.getContext("2d");
canvas.height = 64;
canvas.width = 64;
ctx.font = "64px serif";

let lastGap = 0;

const updateStats = newStats => {
  const formatedStats = mapValues(newStats, formatNumber);
  changeStats(formatedStats);
  changeTitle(formatedStats.gap);
  changeFaviconEmoji(gapEmoji(lastGap, newStats.gap));
  lastGap = newStats.gap;
};

const changeTitle = newTitle => (titleEl.innerHTML = newTitle);
const changeStats = newStats =>
  (codeEl.innerHTML = JSON.stringify(newStats, null, 4));

const gapEmoji = (lastGap, newGap) => {
  if (newGap > lastGap) {
    return "⬆️";
  } else if (newGap < lastGap) {
    return "⬇️";
  } else {
    return "=";
  }
};

const formatNumber = number => new Intl.NumberFormat().format(number);
const mapValues = (obj, func) =>
  Object.keys(obj).reduce((newObj, key) => {
    newObj[key] = func(obj[key]);
    return newObj;
  }, {});

const changeFaviconEmoji = emoji => {
  ctx.fillText(emoji, 0, 64);
  favicon.href = canvas.toDataURL();
};

export { updateStats };
