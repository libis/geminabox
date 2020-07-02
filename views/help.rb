<div class="container">
  <div class="row justify-content-md-center">
    <div class="col-6 ml-3">
      <center>
        <small>To download the gems from this registry:</small>
        <p>
          <code>gem sources -a <%= url.to_s.gsub('://','://username:password@') %></code>
        </p>
        <% if @allow_upload %>
          <small>and to upload gems:</small>
          <p>
            <code>gem install geminabox<br />gem inabox [gemfile]</code>
          </p>
        <% end %>
      </center>
    </div>
  </div>
</div>
