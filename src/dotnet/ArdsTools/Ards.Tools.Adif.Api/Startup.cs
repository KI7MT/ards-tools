using System;
using System.IO;
using System.Reflection;
using Ards.Tools.Domain.Adif.ViewModels;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Swashbuckle.AspNetCore.Swagger;

[assembly: ApiConventionType(typeof(DefaultApiConventions))]
namespace Ards.Tools.Adif.Api
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
            // AddJsonOptions is for Swagger Ptrtty Json Response
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2)
                .AddJsonOptions(options =>
                {
                    options.SerializerSettings.Formatting = Formatting.Indented;
                });

            // ARDS Tools DDomain Context File
            services.AddDbContext<AdifDomain>(options =>
                options.UseNpgsql(Configuration.GetConnectionString("ArdsToolsConnection")));

            // SwaggerUI Services77
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Version = "v1",
                    Title = "ARDS Tools ADIF Public API",
                    Description = "Postman Like Interface to Core Web API Functions",
                    TermsOfService = "None At this time",
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
                // Currently not working.
                var xmlFile = $"{Assembly.GetEntryAssembly().GetName().Name}.xml";
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

            app.UseMvc();

            // Adding Swagger API Client
            app.UseSwagger();

            // Add SwaggerUI
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "ARDS Tools ADIF API");
                c.RoutePrefix = string.Empty;
            });
        }
    }
}
