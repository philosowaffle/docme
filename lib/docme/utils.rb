# docme utils

def clean_attribute(attr)
    attr = attr.delete('+[')
    attr = attr.delete(']')
    attr = attr.delete('-')
    attr
end

def clean_code(line)
    line.gsub!('<', '&lt;')
    line.gsub!('>', '&gt;')

    line
end

def clean_content(line)
    line = line.lstrip
    line.chop!

    line
end

def clean_filename(file)
    file = File.basename(file)
    file = file.split('.')
    file = file[0]

    file
end

def parse_subdirectory(path)

    files_array = []

    # for each file in the sub directory
    Dir.foreach(path) do |f|
        next if f == '.' || f == '..'

        next if f.rindex('.', 0)

        # if another directory then go inside
        if File.directory?(path + '/' + f)

            files_array.concat parse_subdirectory(path + '/' + f)

        else # else parse normally

            page = Docme.j_parse(path + '/' + f)

            # add page to docme dir
            if page
                FileUtils.mv(page, 'docme_site/' + page)
                files_array.push(page)
            end

        end
    end

    files_array

end

def render_index(pages)
    # puts pages

    @pages = pages

    template = '<!DOCTYPE html>
                    <html>

                        <style type="text/css">
                            #wrapper{
                                    width: 70%;
                                    padding-left: 30%;
                                    font-size:2em;
                                }
                        </style>

                        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" media="screen">

                        <body>
                            <div id="wrapper">
                                <div class="list-group">
                                    <% for @page in @pages %>

                                        <% @name = clean_filename(@page) %>
                                        <a href="<%= @page %>" class="list-group-item list-group-item-info"><%= @name %></a>

                                    <% end %>
                                </div>
                            </div>
                        </body>

                    </html>'

    renderer = ERB.new(template)

    File.open('index.html', 'w+') do |f|
        f.write(renderer.result(binding))
    end

    'index.html'

end

def render_site(file, content)

    @collective = content
    @filename = file

    # puts content

    template = '<!DOCTYPE html>
                    <html>

                        <head>
                            <meta name="viewport" content="width=device-width, initial-scale=1">

                            <style type="text/css">
                                body{
                                }
                                #panels-wrapper{
                                    width: 80%;
                                    float: left;
                                    padding-left: 10%;
                                }
                                #side-panel{
                                width: 10%;
                                float: left;
                                padding-left: 10px;
                             }
                             pre-scrollable{
                                overflow-x: scroll;
                                white-space: nowrap;
                             }

                             p.code{
                                border:1px solid #000000;
                                overflow-x:scroll;
                                white-space: pre;
                                font-family:monospace,monospace;
                                font-size:1em;
                                background-color:#f5f5f5;
                                padding:2em;
                            }

                            </style>
                        </head>

                        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" media="screen">


                        <body>
                            <nav class="navbar navbar-default navbar-static-top" role="navigation">
                              <div class="container">
                                <div class="collapse navbar-collapse">
                                    <ul class="nav navbar-nav">
                                        <li><a class="navbar-brand" href="#"><%= @filename%></a></li>
                                    </ul>
                                </div>
                              </div>
                            </nav>
                            <div id="side-panel" class="panel panel-default">
                                <a href="index.html" class="list-group-item list-group-item-info">INDEX</a>
                            </div>
                            <div id="panels-wrapper">
                                <% for @borg in @collective %>
                                    <div class="panel panel-primary">
                                        <% for @attribute in @borg %>
                                            <% if @attribute[0] == "TITLE" %>
                                                <div class="panel-heading" id="<%= @attribute[1]%>">
                                                        <h2 class="panel-title"><%= @attribute[1] %></h2>
                                                  </div>
                                                  <div class="panel-body">
                                            <% end %>
                                            <% if @attribute[0] == "CODE" %>
                                                    <h4>CODE</h4>
                                                        <p class="code"><%= @attribute[1] %></p>
                                            <% end %>
                                            <% if @attribute[0] != "TITLE" && @attribute[0] != "CODE" %>
                                                <% if @attribute[1].class == Hash %>
                                                    <% if @attribute[0] == "ANCHOR" %>
                                                        <h4><%= @attribute[0] %></h4>
                                                        <table class="table">
                                                            <% for @item in @attribute[1]%>
                                                                <tr>
                                                                    <th><%= @item[0] %></th>
                                                                    <td><a href="<%= @item[1] %>"><%= @item[1] %></a></td>
                                                                </tr>
                                                            <% end %>
                                                        </table>
                                                    <% else %>
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
                                                <% end %>
                                                <% if @attribute[0] != "CODE" && @attribute[0] != "TITLE" && @attribute[1].class != Hash%>
                                                    <h4><%= @attribute[0]%></h4>
                                                    <p><%= @attribute[1] %></p>
                                                <% end %>
                                            <%  end %>
                                        <% end %>
                                        </div>
                                    </div>
                                <% end %>
                                </div>

                            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
                        </body>

                    </html>'

    renderer = ERB.new(template)

    page = @filename + '.html'

    File.open(page, 'w+') do |f|
        f.write(renderer.result(binding))
    end

    page

end
