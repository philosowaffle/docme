#docme utils

template = '<!DOCTYPE html>
<html>

    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" media="screen">


    <body>

        <% for borg in collective %>
            <div class="panel panel-default">
                <% for attribute in borg %>
                    <% if attribute[0] == "title" %>
                        <div class="panel-heading">
                                <h3 class="panel-title"><% attribute[1] %></h3>
                          </div>
                    <% end %>
                      <div class="panel-body">
                            Panel Content
                      </div>
            </div>

            <% end %>
        <% end %>

        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
    </body>

</html>'

def cleanAttribute(attr)
    attr = attr.delete("+[")
    attr = attr.delete("]")
    attr = attr.delete("-")
    return attr
end

def renderSite(file, content)

    @collective = content
    @filename = file

    puts content

    template = '<!DOCTYPE html>
                    <html>

                        <head>
                            <meta name="viewport" content="width=device-width, initial-scale=1">

                            <style type="text/css">
                                body{ padding-top:70px;}
                            </style>
                        </head>

                        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" media="screen">


                        <body>

                            <% for @borg in @collective %>
                                <div class="panel panel-primary">
                                    <% for @attribute in @borg %>
                                        <% if @attribute[0] == "title" %>
                                            <div class="panel-heading">
                                                    <h2 class="panel-title"><%= @attribute[1] %></h2>
                                              </div>
                                              <div class="panel-body">
                                        <% end %>
                                        <% if @attribute[0] == "code" %>
                                                <h4>Code</h4>
                                                <div class ="well">
                                                    <pre><code><%= @attribute[1] %></code></pre>
                                                </div>
                                        <% end %>
                                        <% if @attribute[0] != "title" && @attribute[0] != "code"%>
                                            <% if @attribute[1].class == Hash %>
                                                <h4><%= @attribute[0] %></h4>
                                                <table class="table">
                                                    <% for @item in @attribute[1]%>
                                                        <tr>
                                                            <th><%= @item[0] %></th>
                                                            <td><%= @item[1] %></td>
                                                        </tr>
                                                    <% end %>
                                                </table>
                                            <% end %>
                                            <% if @attribute[0] != "code" && @attribute[0] != "title" && @attribute[1].class != Hash%>
                                                <h4><%= @attribute[0]%></h4>
                                                <p><%= @attribute[1] %></p>
                                            <% end %>
                                        <%  end %>
                                    <% end %>
                                    </div>
                                </div>
                            <% end %>

                            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
                        </body>

                    </html>'

    renderer = ERB.new(template)

    File.open("index.html", "w+") do |f|
        f.write(renderer.result(binding))
    end

end

