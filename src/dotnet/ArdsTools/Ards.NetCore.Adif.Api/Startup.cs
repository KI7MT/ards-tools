using System;
using System.IO;
using System.Reflection;
using Ards.NetCore.Adif.Domain.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Formatters;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Swashbuckle.AspNetCore.Swagger;


namespace Ards.NetCore.Adif.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2)
                .AddXmlSerializerFormatters()
                .AddXmlDataContractSerializerFormatters();

            services.AddMvc(options =>
            {
                options.OutputFormatters.RemoveType<TextOutputFormatter>();
                options.OutputFormatters.RemoveType<HttpNoContentOutputFormatter>();
            });

            // Development Context File
            services.AddDbContext<AdifContext>(options =>
                options.UseNpgsql(Configuration.GetConnectionString("DefaultConnection")));
            // SwaggerUI Services
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Version = "v1",
                    Title = "Amateur Radio Data Service ADIF API",
                    Description = "Postman Like Interface documenting ADIF endpoints.",
                    TermsOfService = "https://github.com/KI7MT/ards-tools/blob/master/LICENSE",
                    Contact = new Contact
                    {
                        Name = "Greg Beam",
                        Email = "ki7mt01@gmail.com",
                        Url = "www.ki7mt.com"
                    },
                    License = new License
                    {
                        Name = "GPLv3",
                        Url = "https://www.gnu.org/licenses/gpl-3.0.en.html"
                    }
                });
                // Set the comments path for the Swagger JSON and UI.
                var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
                c.IncludeXmlComments(xmlPath);
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            // Adding Swagger Client
            app.UseSwagger();

            // Add SwaggerUI with default root path
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "ADIF API V1");

                // empty root path sets the API entrypoint to: localhost:<port>/index.html
                c.RoutePrefix = string.Empty;
            });

            // Add default MVC service
            app.UseMvc();
        }
    }
}
