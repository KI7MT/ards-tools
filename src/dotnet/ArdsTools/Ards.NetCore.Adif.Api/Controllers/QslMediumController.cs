using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/QslMedium")]
    [ApiController]
    public class QslMediumController : ControllerBase
    {
        private readonly AdifContext _context;

        public QslMediumController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/QslMedium
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QslMedium>>> GetQslMedium()
        {
            return await _context.QslMedium.ToListAsync();
        }

        // GET: api/QslMedium/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QslMedium>> GetQslMedium(int id)
        {
            var qslMedium = await _context.QslMedium.FindAsync(id);

            if (qslMedium == null)
            {
                return NotFound();
            }

            return qslMedium;
        }

        // PUT: api/QslMedium/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQslMedium(int id, QslMedium qslMedium)
        {
            if (id != qslMedium.Id)
            {
                return BadRequest();
            }

            _context.Entry(qslMedium).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QslMediumExists(id))
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

        // POST: api/QslMedium
        [HttpPost]
        public async Task<ActionResult<QslMedium>> PostQslMedium(QslMedium qslMedium)
        {
            _context.QslMedium.Add(qslMedium);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQslMedium", new { id = qslMedium.Id }, qslMedium);
        }

        // DELETE: api/QslMedium/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<QslMedium>> DeleteQslMedium(int id)
        {
            var qslMedium = await _context.QslMedium.FindAsync(id);
            if (qslMedium == null)
            {
                return NotFound();
            }

            _context.QslMedium.Remove(qslMedium);
            await _context.SaveChangesAsync();

            return qslMedium;
        }

        private bool QslMediumExists(int id)
        {
            return _context.QslMedium.Any(e => e.Id == id);
        }
    }
}
