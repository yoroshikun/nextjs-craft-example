const getLivePreviewToken = (path: string): string => {
  let m = path.match(/\btoken=([^&]+)/);
  return m && m[1] ? m[1] : "";
};

export default getLivePreviewToken;
