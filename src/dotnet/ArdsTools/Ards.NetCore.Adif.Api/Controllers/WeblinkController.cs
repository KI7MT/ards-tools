using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/Weblink")]
    [ApiController]
    public class WeblinkController : ControllerBase
    {
        private readonly AdifContext _context;

        public WeblinkController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/Weblink
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Weblink>>> GetWeblink()
        {
            return await _context.Weblink.ToListAsync();
        }

        // GET: api/Weblink/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Weblink>> GetWeblink(int id)
        {
            var weblink = await _context.Weblink.FindAsync(id);

            if (weblink == null)
            {
                return NotFound();
            }

            return weblink;
        }

        // PUT: api/Weblink/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutWeblink(int id, Weblink weblink)
        {
            if (id != weblink.Id)
            {
                return BadRequest();
            }

            _context.Entry(weblink).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WeblinkExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Weblink
        [HttpPost]
        public async Task<ActionResult<Weblink>> PostWeblink(Weblink weblink)
        {
            _context.Weblink.Add(weblink);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetWeblink", new { id = weblink.Id }, weblink);
        }

        // DELETE: api/Weblink/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Weblink>> DeleteWeblink(int id)
        {
            var weblink = await _context.Weblink.FindAsync(id);
            if (weblink == null)
            {
                return NotFound();
            }

            _context.Weblink.Remove(weblink);
            await _context.SaveChangesAsync();

            return weblink;
        }

        private bool WeblinkExists(int id)
        {
            return _context.Weblink.Any(e => e.Id == id);
        }
    }
}
