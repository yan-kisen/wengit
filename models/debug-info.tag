<debug-info>
  <div class="debug-info">
        <!-- All of the Node.js APIs are available in this renderer process. -->
        <dl>
            <dt>Node</dt>
            <dd>{opts.processVersion}</dd>
            <dt>Chromium</dt>
            <dd>{opts.chromeVersion}</dd>
            <dt>Electron</dt>
            <dd>{opts.electronVersion}</dd>
        </dl>
    </div>
  <style scoped>
    .debug-info {
      display:none;
    }
  </style>
</debug-info>