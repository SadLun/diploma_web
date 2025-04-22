import { useEffect } from "react";

const useMiddleClickSearch = () => {
  useEffect(() => {
    const handleMouseDown = (event: MouseEvent) => {
      if (event.button === 1) {
        event.preventDefault();

        let selectedText = window.getSelection()?.toString().trim() || "";

        if (!selectedText) {
          const element = document.elementFromPoint(event.clientX, event.clientY);
          if (element && element.textContent) {
            selectedText = element.textContent.trim();
          }
        }

        if (selectedText) {
          const searchEngine = "https://www.google.com/search?q=";
          const searchUrl = searchEngine + encodeURIComponent(selectedText);
          window.open(searchUrl, "_blank");
        }
      }
    };

    document.addEventListener("mousedown", handleMouseDown);
    return () => document.removeEventListener("mousedown", handleMouseDown);
  }, []);
};

export default useMiddleClickSearch;