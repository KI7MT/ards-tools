using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/CreditFacet")]
    [ApiController]
    public class CreditFacetController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public CreditFacetController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/CreditFacet
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CreditFacet>>> GetCreditFacet()
        {
            return await _context.CreditFacet.ToListAsync();
        }

        // GET: api/CreditFacet/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CreditFacet>> GetCreditFacet(int id)
        {
            var creditFacet = await _context.CreditFacet.FindAsync(id);

            if (creditFacet == null)
            {
                return NotFound();
            }

            return creditFacet;
        }

        // PUT: api/CreditFacet/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCreditFacet(int id, CreditFacet creditFacet)
        {
            if (id != creditFacet.Id)
            {
                return BadRequest();
            }

            _context.Entry(creditFacet).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CreditFacetExists(id))
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

        // POST: api/CreditFacet
        [HttpPost]
        public async Task<ActionResult<CreditFacet>> PostCreditFacet(CreditFacet creditFacet)
        {
            _context.CreditFacet.Add(creditFacet);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCreditFacet", new { id = creditFacet.Id }, creditFacet);
        }

        // DELETE: api/CreditFacet/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CreditFacet>> DeleteCreditFacet(int id)
        {
            var creditFacet = await _context.CreditFacet.FindAsync(id);
            if (creditFacet == null)
            {
                return NotFound();
            }

            _context.CreditFacet.Remove(creditFacet);
            await _context.SaveChangesAsync();

            return creditFacet;
        }

        private bool CreditFacetExists(int id)
        {
            return _context.CreditFacet.Any(e => e.Id == id);
        }
    }
}
