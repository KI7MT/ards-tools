using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/CountyName")]
    [ApiController]
    public class CountyNameController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public CountyNameController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/CountyName
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CountyName>>> GetCountyName()
        {
            return await _context.CountyName.ToListAsync();
        }

        // GET: api/CountyName/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CountyName>> GetCountyName(int id)
        {
            var countyName = await _context.CountyName.FindAsync(id);

            if (countyName == null)
            {
                return NotFound();
            }

            return countyName;
        }

        // PUT: api/CountyName/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCountyName(int id, CountyName countyName)
        {
            if (id != countyName.Id)
            {
                return BadRequest();
            }

            _context.Entry(countyName).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CountyNameExists(id))
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

        // POST: api/CountyName
        [HttpPost]
        public async Task<ActionResult<CountyName>> PostCountyName(CountyName countyName)
        {
            _context.CountyName.Add(countyName);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCountyName", new { id = countyName.Id }, countyName);
        }

        // DELETE: api/CountyName/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CountyName>> DeleteCountyName(int id)
        {
            var countyName = await _context.CountyName.FindAsync(id);
            if (countyName == null)
            {
                return NotFound();
            }

            _context.CountyName.Remove(countyName);
            await _context.SaveChangesAsync();

            return countyName;
        }

        private bool CountyNameExists(int id)
        {
            return _context.CountyName.Any(e => e.Id == id);
        }
    }
}
