import React, { useEffect } from 'react';
import './ParticlesBackground.css';

declare global {
  interface Window {
    particlesJS: any;
  }
}

const ParticlesBackground = () => {
  useEffect(() => {
    window.particlesJS("particles", {
      particles: {
        number: { value: 50, density: { enable: true, value_area: 800 } },
        color: { value: "#00FF94" },
        shape: { type: "circle" },
        opacity: { value: 0.5, random: true },
        size: { value: 3, random: true },
        line_linked: {
          enable: true,
          distance: 150,
          color: "#00B36B",
          opacity: 0.4,
          width: 1
        },
        move: {
          enable: true,
          speed: 2,
          direction: "none",
          random: false,
          straight: false,
          out_mode: "out",
          bounce: false
        }
      },
      interactivity: {
        detect_on: "canvas",
        events: {
          onhover: { enable: true, mode: "grab" },
          onclick: { enable: true, mode: "push" },
          resize: true
        },
        modes: {
          grab: {
            distance: 140,
            line_linked: {
              opacity: 0.8
            }
          }
        }
      },
      retina_detect: true
    });
  }, []);

  return <div id="particles" className="particles-container"></div>;
};

export default ParticlesBackground; 