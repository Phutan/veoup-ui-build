import React, { useState } from "react";

export default function VeoUpApp() {
  const [prompts, setPrompts] = useState([{id:'Vi_01', text:'"4K","Drone sunrise","Wind","Từ sâu..."'}]);
  const [jobs, setJobs] = useState([]);

  function startCreateAll() {
    const newJobs = prompts.map((pr, i) => ({
      id: i + 1,
      code: pr.id,
      progress: 0,
      status: "processing",
    }));
    setJobs(newJobs);
    newJobs.forEach((job, i) => {
      const interval = setInterval(() => {
        setJobs((curr) =>
          curr.map((j) =>
            j.id === job.id
              ? { ...j, progress: Math.min(100, j.progress + Math.floor(Math.random() * 25)) }
              : j
          )
        );
      }, 500);
      setTimeout(() => clearInterval(interval), 6000);
    });
  }

  return (
    <div style={{ padding: 20, fontFamily: 'sans-serif' }}>
      <h1 style={{ fontSize: 22 }}>VeoUp UI — Mock Interface</h1>
      <button onClick={startCreateAll} style={{ marginTop: 12 }}>BẮT ĐẦU TẠO VIDEO</button>
      <div style={{ marginTop: 20 }}>
        {jobs.map((j) => (
          <div key={j.id} style={{ marginBottom: 8 }}>
            {j.code}: <progress value={j.progress} max="100" style={{ width: 200 }} /> {j.progress}%
          </div>
        ))}
      </div>
    </div>
  );
}
