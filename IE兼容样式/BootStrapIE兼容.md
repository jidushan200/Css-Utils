# BootStrap3的组件——IE专供

# JavaScript 插件

jQuery 插件为 Bootstrap 的组件赋予了“生命”。可以简单地一次性引入所有插件，或者逐个引入到你的页面中。

# 概览

## 单个还是全部引入

JavaScript 插件可以单个引入（使用 Bootstrap 提供的单个 `*.js` 文件），或者一次性全部引入（使用 `bootstrap.js` 或压缩版的 `bootstrap.min.js`）。

#### 建议使用压缩版的 JavaScript 文件

`bootstrap.js` 和 `bootstrap.min.js` 都包含了所有插件，你在使用时，只需选择一个引入页面就可以了。

#### 插件之间的依赖关系

某些插件和 CSS 组件依赖于其它插件。如果你是单个引入每个插件的，请确保在文档中检查插件之间的依赖关系。注意，所有插件都依赖 jQuery （也就是说，jQuery必须在所有插件**之前**引入页面）。 [`bower.json`](https://github.com/twbs/bootstrap/blob/v3-dev/bower.json) 文件中列出了 Bootstrap 所支持的 jQuery 版本。

## data 属性

你可以仅仅通过 data 属性 API 就能使用所有的 Bootstrap 插件，无需写一行 JavaScript 代码。这是 Bootstrap 中的一等 API，也应该是你的首选方式。

话又说回来，在某些情况下可能需要将此功能关闭。因此，我们还提供了关闭 data 属性 API 的方法，即解除以 `data-api` 为命名空间并绑定在文档上的事件。就像下面这样：

```
$(document).off('.data-api')
```

另外，如果是针对某个特定的插件，只需在 `data-api` 前面添加那个插件的名称作为命名空间，如下：

```
$(document).off('.alert.data-api')
```

#### Only one plugin per element via data attributes

Don't use data attributes from multiple plugins on the same element. For example, a button cannot both have a tooltip and toggle a modal. To accomplish this, use a wrapping element.

## 编程方式的 API

我们为所有 Bootstrap 插件提供了纯 JavaScript 方式的 API。所有公开的 API 都是支持单独或链式调用方式，并且返回其所操作的元素集合（注：和jQuery的调用形式一致）。

```
$('.btn.danger').button('toggle').addClass('fat')
```

所有方法都可以接受一个可选的 option 对象作为参数，或者一个代表特定方法的字符串，或者什么也不提供（在这种情况下，插件将会以默认值初始化）：

```
$('#myModal').modal()                      // 以默认值初始化
$('#myModal').modal({ keyboard: false })   // initialized with no keyboard
$('#myModal').modal('show')                // 初始化后立即调用 show 方法
```

每个插件还通过 `Constructor` 属性暴露了其原始的构造函数：`$.fn.popover.Constructor`。如果你想获取某个插件的实例，可以直接通过页面元素获取：`$('[rel="popover"]').data('popover')`。

#### 默认设置

每个插件都可以通过修改其自身的 `Constructor.DEFAULTS` 对象从而改变插件的默认设置：

```
$.fn.modal.Constructor.DEFAULTS.keyboard = false // 将模态框插件的 `keyboard` 默认选参数置为 false
```

## 避免命名空间冲突

某些时候可能需要将 Bootstrap 插件与其他 UI 框架共同使用。在这种情况下，命名空间冲突随时可能发生。如果不幸发生了这种情况，你可以通过调用插件的 `.noConflict` 方法恢复其原始值。

```
var bootstrapButton = $.fn.button.noConflict() // return $.fn.button to previously assigned value
$.fn.bootstrapBtn = bootstrapButton            // give $().bootstrapBtn the Bootstrap functionality
```

## 事件

Bootstrap 为大部分插件所具有的动作提供了自定义事件。一般来说，这些事件都有不定式和过去式两种动词的命名形式，例如，不定式形式的动词（例如 `show`）表示其在事件开始时被触发；而过去式动词（例如 `shown` ）表示在动作执行完毕之后被触发。

从 3.0.0 版本开始，所有 Bootstrap 事件的名称都采用命名空间方式。

所有以不定式形式的动词命名的事件都提供了 `preventDefault` 功能。这就赋予你在动作开始执行前将其停止的能力。

```
$('#myModal').on('show.bs.modal', function (e) {
  if (!data) return e.preventDefault() // 阻止模态框的展示
})
```

## Sanitizer

Tooltips and Popovers use our built-in sanitizer to sanitize options which accept HTML.

The default `whiteList` value is the following:

```
var ARIA_ATTRIBUTE_PATTERN = /^aria-[\w-]*$/i
var DefaultWhitelist = {
  // Global attributes allowed on any supplied element below.
  '*': ['class', 'dir', 'id', 'lang', 'role', ARIA_ATTRIBUTE_PATTERN],
  a: ['target', 'href', 'title', 'rel'],
  area: [],
  b: [],
  br: [],
  col: [],
  code: [],
  div: [],
  em: [],
  hr: [],
  h1: [],
  h2: [],
  h3: [],
  h4: [],
  h5: [],
  h6: [],
  i: [],
  img: ['src', 'alt', 'title', 'width', 'height'],
  li: [],
  ol: [],
  p: [],
  pre: [],
  s: [],
  small: [],
  span: [],
  sub: [],
  sup: [],
  strong: [],
  u: [],
  ul: []
}
```

If you want to add new values to this default `whiteList` you can do the following:

```
var myDefaultWhiteList = $.fn.tooltip.Constructor.DEFAULTS.whiteList

// To allow table elements
myDefaultWhiteList.table = []

// To allow td elements and data-option attributes on td elements
myDefaultWhiteList.td = ['data-option']

// You can push your custom regex to validate your attributes.
// Be careful about your regular expressions being too lax
var myCustomRegex = /^data-my-app-[\w-]+/
myDefaultWhiteList['*'].push(myCustomRegex)
```

If you want to bypass our sanitizer because you prefer to use a dedicated library, for example [DOMPurify](https://www.npmjs.com/package/dompurify), you should do the following:

```
$('#yourTooltip').tooltip({
  sanitizeFn: function (content) {
    return DOMPurify.sanitize(content)
  }
})
```

#### Browsers without `document.implementation.createHTMLDocument`

In case of browsers that don't support `document.implementation.createHTMLDocument`, like Internet Explorer 8, the built-in sanitize function returns the HTML as is.

If you want to perform sanitization in this case, please specify `sanitizeFn` and use an external library like [DOMPurify](https://www.npmjs.com/package/dompurify).

## 插件的版本号

每个 Bootstrap 的 jQuery 插件的版本号都可以通过插件的构造函数上的 `VERSION` 属性获取到。例如工具提示框（tooltip）插件：

```
$.fn.tooltip.Constructor.VERSION // => "3.4.1"
```

## 未对禁用 JavaScript 的浏览器提供补救措施

Bootstrap 插件未对禁用 JavaScript 的浏览器提供补救措施。如果你对这种情况下的用户体验很关心的话，请添加 [``](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/noscript) 标签向你的用户进行解释（并告诉他们如何启用 JavaScript），或者按照你自己的方式提供补救措施。

#### 第三方工具库

**Bootstrap 官方不提供对第三方 JavaScript 工具库的支持，**例如 Prototype 或 jQuery UI。除了 `.noConflict` 和为事件名称添加命名空间，还可能会有兼容性方面的问题，这就需要你自己来处理了。

# 过渡效果 transition.js

## 关于过渡效果

对于简单的过渡效果，只需将 `transition.js` 和其它 JS 文件一起引入即可。如果你使用的是编译（或压缩）版的 `bootstrap.js` 文件，就无需再单独将其引入了。

## 包含的内容

Transition.js 是针对 `transitionEnd` 事件的一个基本辅助工具，也是对 CSS 过渡效果的模拟。它被其它插件用来检测当前浏览器对是否支持 CSS 的过渡效果。

## 禁用过度效果

通过下面的 JavaScript 代码可以在全局范围禁用过渡效果，并且必须将此代码放在 `transition.js` （或 `bootstrap.js` 或 `bootstrap.min.js`）后面，确保在 js 文件加载完毕后再执行下面的代码：

```
$.support.transition = false
```

# 模态框 modal.js

模态框经过了优化，更加灵活，以弹出对话框的形式出现，具有最小和最实用的功能集。

#### 不支持同时打开多个模态框

千万不要在一个模态框上重叠另一个模态框。要想同时支持多个模态框，需要自己写额外的代码来实现。

#### 模态框的 HTML 代码放置的位置

务必将模态框的 HTML 代码放在文档的最高层级内（也就是说，尽量作为 body 标签的直接子元素），以避免其他组件影响模态框的展现和/或功能。

#### 对于移动设备的附加说明

在移动设备上使用模态框有一些额外要注意的事项。请参考 [对浏览器的支持](https://v3.bootcss.com/getting-started/#support-fixed-position-keyboards) 章节获取更多信息。

**Due to how HTML5 defines its semantics, the `autofocus` HTML attribute has no effect in Bootstrap modals.** To achieve the same effect, use some custom JavaScript:

```
$('#myModal').on('shown.bs.modal', function () {
  $('#myInput').focus()
})
```

## 实例

### 静态实例

以下模态框包含了模态框的头、体和一组放置于底部的按钮。

×

#### Modal title

One fine body…

Close Save changes

```
<div class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Modal title</h4>
      </div>
      <div class="modal-body">
        <p>One fine body&hellip;</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
```

### 动态实例

点击下面的按钮即可通过 JavaScript 启动一个模态框。此模态框将从上到下、逐渐浮现到页面前。

Launch demo modal

```
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
```

#### 增强模态框的可访问性

务必为 `.modal` 添加 `role="dialog"` 和 `aria-labelledby="..."` 属性，用于指向模态框的标题栏；为 `.modal-dialog` 添加 `aria-hidden="true"` 属性。

另外，你还应该通过 `aria-describedby` 属性为模态框 `.modal` 添加描述性信息。

#### 嵌入 YouTube 视频（天朝无用）

在模态框中嵌入 YouTube 视频需要增加一些额外的 JavaScript 代码，用于自动停止重放等功能，这些代码并没有在 Bootstrap 中提供。请参考这份[发布在 Stack Overflow 上的文章](https://stackoverflow.com/questions/18622508/bootstrap-3-and-youtube-in-modal)。

## 可选尺寸

模态框提供了两个可选尺寸，通过为 `.modal-dialog` 增加一个样式调整类实现。

大模态框 小模态框

```
<!-- Large modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg">Large modal</button>

<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      ...
    </div>
  </div>
</div>

<!-- Small modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm">Small modal</button>

<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      ...
    </div>
  </div>
</div>
```

## 禁止动画效果

如果你不需要模态框弹出时的动画效果（淡入淡出效果），删掉 `.fade` 类即可。

```
<div class="modal" tabindex="-1" role="dialog" aria-labelledby="...">
  ...
</div>
```

## Using the grid system

To take advantage of the Bootstrap grid system within a modal, just nest `.row`s within the `.modal-body` and then use the normal grid system classes.

Launch demo modal

```
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="gridSystemModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-4">.col-md-4</div>
          <div class="col-md-4 col-md-offset-4">.col-md-4 .col-md-offset-4</div>
        </div>
        <div class="row">
          <div class="col-md-3 col-md-offset-3">.col-md-3 .col-md-offset-3</div>
          <div class="col-md-2 col-md-offset-4">.col-md-2 .col-md-offset-4</div>
        </div>
        <div class="row">
          <div class="col-md-6 col-md-offset-3">.col-md-6 .col-md-offset-3</div>
        </div>
        <div class="row">
          <div class="col-sm-9">
            Level 1: .col-sm-9
            <div class="row">
              <div class="col-xs-8 col-sm-6">
                Level 2: .col-xs-8 .col-sm-6
              </div>
              <div class="col-xs-4 col-sm-6">
                Level 2: .col-xs-4 .col-sm-6
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
```

## Varying modal content based on trigger button

Have a bunch of buttons that all trigger the same modal, just with slightly different contents? Use `event.relatedTarget` and [HTML `data-*` attributes](https://developer.mozilla.org/en-US/docs/Learn/HTML/Howto/Use_data_attributes) (possibly [via jQuery](https://api.jquery.com/data/)) to vary the contents of the modal depending on which button was clicked. See the Modal Events docs for details on `relatedTarget`,

Open modal for @mdo Open modal for @fat Open modal for @getbootstrap ...more buttons...

```
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">Open modal for @mdo</button>
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@fat">Open modal for @fat</button>
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">Open modal for @getbootstrap</button>
...more buttons...

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="control-label">Recipient:</label>
            <input type="text" class="form-control" id="recipient-name">
          </div>
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Send message</button>
      </div>
    </div>
  </div>
</div>
$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var recipient = button.data('whatever') // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
  modal.find('.modal-body input').val(recipient)
})
```

## 用法

通过 data 属性或 JavaScript 调用模态框插件，可以根据需要动态展示隐藏的内容。模态框弹出时还会为 `<body>` 元素添加 `.modal-open` 类，从而覆盖页面默认的滚动行为，并且还会自动生成一个 `.modal-backdrop` 元素用于提供一个可点击的区域，点击此区域就即可关闭模态框。

### 通过 data 属性

不需写 JavaScript 代码也可激活模态框。通过在一个起控制器作用的元素（例如：按钮）上添加 `data-toggle="modal"` 属性，或者 `data-target="#foo"` 属性，再或者 `href="#foo"` 属性，用于指向被控制的模态框。

```
<button type="button" data-toggle="modal" data-target="#myModal">Launch modal</button>
```

### 通过 JavaScript 调用

只需一行 JavaScript 代码，即可通过元素的 id `myModal` 调用模态框：

```
$('#myModal').modal(options)
```

### 参数

可以将选项通过 data 属性或 JavaScript 代码传递。对于 data 属性，需要将参数名称放到 `data-` 之后，例如 `data-backdrop=""`。

| 名称     | 类型                         | 默认值 | 描述                                                         |
| :------- | :--------------------------- | :----- | :----------------------------------------------------------- |
| backdrop | boolean 或 字符串 `'static'` | true   | Includes a modal-backdrop element. Alternatively, specify `static` for a backdrop which doesn't close the modal on click. |
| keyboard | boolean                      | true   | 键盘上的 esc 键被按下时关闭模态框。                          |
| show     | boolean                      | true   | 模态框初始化之后就立即显示出来。                             |
| remote   | path                         | false  | **This option is deprecated since v3.3.0 and has been removed in v4.** We recommend instead using client-side templating or a data binding framework, or calling [jQuery.load](https://api.jquery.com/load/) yourself.如果提供的是 URL，将利用 jQuery 的 `load` 方法**从此 URL 地址加载要展示的内容（只加载一次）**并插入 `.modal-content` 内。如果使用的是 data 属性 API，还可以利用 `href` 属性指定内容来源地址。下面是一个实例：`<a data-toggle="modal" href="remote.html" data-target="#modal">Click me</a>` |

### 方法

#### `.modal(options)`

将页面中的某块内容作为模态框激活。接受可选参数 `object`。

```
$('#myModal').modal({
  keyboard: false
})
```

#### `.modal('toggle')`

手动打开或关闭模态框。**在模态框显示或隐藏之前返回到主调函数中**（也就是，在触发 `shown.bs.modal` 或 `hidden.bs.modal` 事件之前）。

```
$('#myModal').modal('toggle')
```

#### `.modal('show')`

手动打开模态框。**在模态框显示之前返回到主调函数中** （也就是，在触发 `shown.bs.modal` 事件之前）。

```
$('#myModal').modal('show')
```

#### `.modal('hide')`

手动隐藏模态框。**在模态框隐藏之前返回到主调函数中** （也就是，在触发 `hidden.bs.modal` 事件之前）。

```
$('#myModal').modal('hide')
```

#### `.modal('handleUpdate')`

Readjusts the modal's positioning to counter a scrollbar in case one should appear, which would make the modal jump to the left.

Only needed when the height of the modal changes while it is open.

```
$('#myModal').modal('handleUpdate')
```

### 事件

Bootstrap 的模态框类提供了一些事件用于监听并执行你自己的代码。

All modal events are fired at the modal itself (i.e. at the `<div class="modal">`).

| 事件类型        | 描述                                                         |
| :-------------- | :----------------------------------------------------------- |
| show.bs.modal   | `show` 方法调用之后立即触发该事件。如果是通过点击某个作为触发器的元素，则此元素可以通过事件的 `relatedTarget` 属性进行访问。 |
| shown.bs.modal  | 此事件在模态框已经显示出来（并且同时在 CSS 过渡效果完成）之后被触发。如果是通过点击某个作为触发器的元素，则此元素可以通过事件的 `relatedTarget` 属性进行访问。 |
| hide.bs.modal   | `hide` 方法调用之后立即触发该事件。                          |
| hidden.bs.modal | 此事件在模态框被隐藏（并且同时在 CSS 过渡效果完成）之后被触发。 |
| loaded.bs.modal | 从`远端的数据源`加载完数据之后触发该事件。                   |

```
$('#myModal').on('hidden.bs.modal', function (e) {
  // do something...
})
```

# Dropdowns dropdown.js

## Examples

Add dropdown menus to nearly anything with this simple plugin, including the navbar, tabs, and pills.

### Within a navbar

[Project Name](https://v3.bootcss.com/javascript/#)

- [Dropdown ](https://v3.bootcss.com/javascript/#)
- [Dropdown ](https://v3.bootcss.com/javascript/#)

- [Dropdown ](https://v3.bootcss.com/javascript/#)

### Within pills

- [Regular link](https://v3.bootcss.com/javascript/#)
- [Dropdown ](https://v3.bootcss.com/javascript/#)
- [Dropdown ](https://v3.bootcss.com/javascript/#)
- [Dropdown ](https://v3.bootcss.com/javascript/#)

## Usage

Via data attributes or JavaScript, the dropdown plugin toggles hidden content (dropdown menus) by toggling the `.open` class on the parent list item.

On mobile devices, opening a dropdown adds a `.dropdown-backdrop` as a tap area for closing dropdown menus when tapping outside the menu, a requirement for proper iOS support. **This means that switching from an open dropdown menu to a different dropdown menu requires an extra tap on mobile.**

Note: The `data-toggle="dropdown"` attribute is relied on for closing dropdown menus at an application level, so it's a good idea to always use it.

### Via data attributes

Add `data-toggle="dropdown"` to a link or button to toggle a dropdown.

```
<div class="dropdown">
  <button id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Dropdown trigger
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" aria-labelledby="dLabel">
    ...
  </ul>
</div>
```

To keep URLs intact with link buttons, use the `data-target` attribute instead of `href="#"`.

```
<div class="dropdown">
  <a id="dLabel" data-target="#" href="http://example.com/" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
    Dropdown trigger
    <span class="caret"></span>
  </a>

  <ul class="dropdown-menu" aria-labelledby="dLabel">
    ...
  </ul>
</div>
```

### Via JavaScript

Call the dropdowns via JavaScript:

```
$('.dropdown-toggle').dropdown()
```

#### `data-toggle="dropdown"` still required

Regardless of whether you call your dropdown via JavaScript or instead use the data-api, `data-toggle="dropdown"` is always required to be present on the dropdown's trigger element.

### Options

*None*

### Methods

#### `$().dropdown('toggle')`

Toggles the dropdown menu of a given navbar or tabbed navigation.

### Events

All dropdown events are fired at the `.dropdown-menu`'s parent element.

All dropdown events have a `relatedTarget` property, whose value is the toggling anchor element.

| Event Type         | Description                                                  |
| :----------------- | :----------------------------------------------------------- |
| show.bs.dropdown   | This event fires immediately when the show instance method is called. |
| shown.bs.dropdown  | This event is fired when the dropdown has been made visible to the user (will wait for CSS transitions, to complete). |
| hide.bs.dropdown   | This event is fired immediately when the hide instance method has been called. |
| hidden.bs.dropdown | This event is fired when the dropdown has finished being hidden from the user (will wait for CSS transitions, to complete). |

```
$('#myDropdown').on('show.bs.dropdown', function () {
  // do something…
})
```

# 滚动监听 scrollspy.js

## 导航条实例

滚动监听插件是用来根据滚动条所处的位置来自动更新导航项的。如下所示，滚动导航条下面的区域并关注导航项的变化。下拉菜单中的条目也会自动高亮显示。

[Project Name](https://v3.bootcss.com/javascript/#)

- [@fat](https://v3.bootcss.com/javascript/#fat)
- [@mdo](https://v3.bootcss.com/javascript/#mdo)
- [Dropdown ](https://v3.bootcss.com/javascript/#)

#### @fat

Ad leggings keytar, brunch id art party dolor labore. Pitchfork yr enim lo-fi before they sold out qui. Tumblr farm-to-table bicycle rights whatever. Anim keffiyeh carles cardigan. Velit seitan mcsweeney's photo booth 3 wolf moon irure. Cosby sweater lomo jean shorts, williamsburg hoodie minim qui you probably haven't heard of them et cardigan trust fund culpa biodiesel wes anderson aesthetic. Nihil tattooed accusamus, cred irony biodiesel keffiyeh artisan ullamco consequat.

#### @mdo

Veniam marfa mustache skateboard, adipisicing fugiat velit pitchfork beard. Freegan beard aliqua cupidatat mcsweeney's vero. Cupidatat four loko nisi, ea helvetica nulla carles. Tattooed cosby sweater food truck, mcsweeney's quis non freegan vinyl. Lo-fi wes anderson +1 sartorial. Carles non aesthetic exercitation quis gentrify. Brooklyn adipisicing craft beer vice keytar deserunt.

#### one

Occaecat commodo aliqua delectus. Fap craft beer deserunt skateboard ea. Lomo bicycle rights adipisicing banh mi, velit ea sunt next level locavore single-origin coffee in magna veniam. High life id vinyl, echo park consequat quis aliquip banh mi pitchfork. Vero VHS est adipisicing. Consectetur nisi DIY minim messenger bag. Cred ex in, sustainable delectus consectetur fanny pack iphone.

#### two

In incididunt echo park, officia deserunt mcsweeney's proident master cleanse thundercats sapiente veniam. Excepteur VHS elit, proident shoreditch +1 biodiesel laborum craft beer. Single-origin coffee wayfarers irure four loko, cupidatat terry richardson master cleanse. Assumenda you probably haven't heard of them art party fanny pack, tattooed nulla cardigan tempor ad. Proident wolf nesciunt sartorial keffiyeh eu banh mi sustainable. Elit wolf voluptate, lo-fi ea portland before they sold out four loko. Locavore enim nostrud mlkshk brooklyn nesciunt.

#### three

Ad leggings keytar, brunch id art party dolor labore. Pitchfork yr enim lo-fi before they sold out qui. Tumblr farm-to-table bicycle rights whatever. Anim keffiyeh carles cardigan. Velit seitan mcsweeney's photo booth 3 wolf moon irure. Cosby sweater lomo jean shorts, williamsburg hoodie minim qui you probably haven't heard of them et cardigan trust fund culpa biodiesel wes anderson aesthetic. Nihil tattooed accusamus, cred irony biodiesel keffiyeh artisan ullamco consequat.

Keytar twee blog, culpa messenger bag marfa whatever delectus food truck. Sapiente synth id assumenda. Locavore sed helvetica cliche irony, thundercats you probably haven't heard of them consequat hoodie gluten-free lo-fi fap aliquip. Labore elit placeat before they sold out, terry richardson proident brunch nesciunt quis cosby sweater pariatur keffiyeh ut helvetica artisan. Cardigan craft beer seitan readymade velit. VHS chambray laboris tempor veniam. Anim mollit minim commodo ullamco thundercats.

## 用法

#### 依赖 Bootstrap 的导航组件

滚动监听插件依赖 [Bootstrap 的导航组件](https://v3.bootcss.com/components/#nav) 用于高亮显示当前激活的链接。

#### Resolvable ID targets required

Navbar links must have resolvable id targets. For example, a `<a href="#home">home</a>` must correspond to something in the DOM like `<div id="home"></div>`.

#### Non-`:visible` target elements ignored

Target elements that are not [`:visible` according to jQuery](https://api.jquery.com/visible-selector/) will be ignored and their corresponding nav items will never be highlighted.

### 需要相对定位（relative positioning）

无论何种实现方式，滚动监听都需要被监听的组件是 `position: relative;` 即相对定位方式。大多数时候是监听 `<body>` 元素。When scrollspying on elements other than the `<body>`, be sure to have a `height` set and `overflow-y: scroll;` applied.

### 通过 data 属性调用

To easily add scrollspy behavior to your topbar navigation, add `data-spy="scroll"` to the element you want to spy on (most typically this would be the `<body>`). Then add the `data-target` attribute with the ID or class of the parent element of any Bootstrap `.nav` component.

```
body {
  position: relative;
}
<body data-spy="scroll" data-target="#navbar-example">
  ...
  <div id="navbar-example">
    <ul class="nav nav-tabs" role="tablist">
      ...
    </ul>
  </div>
  ...
</body>
```

### 通过 JavaScript 调用

在 CSS 中添加 `position: relative;` 之后，通过 JavaScript 代码启动滚动监听插件：

```
$('body').scrollspy({ target: '#navbar-example' })
```

### 方法

#### `.scrollspy('refresh')`

当使用滚动监听插件的同时在 DOM 中添加或删除元素后，你需要像下面这样调用此刷新（ refresh） 方法：

```
$('[data-spy="scroll"]').each(function () {
  var $spy = $(this).scrollspy('refresh')
})
```

### 参数

可以通过 data 属性或 JavaScript 传递参数。对于 data 属性，其名称是将参数名附着到 `data-` 后面组成，例如 `data-offset=""`。

| 名称   | 类型   | 默认值 | 描述                                         |
| :----- | :----- | :----- | :------------------------------------------- |
| offset | number | 10     | 计算滚动位置时相对于顶部的偏移量（像素数）。 |

### 事件

| 事件类型              | 描述                                                 |
| :-------------------- | :--------------------------------------------------- |
| activate.bs.scrollspy | 每当一个新条目被激活后都将由滚动监听插件触发此事件。 |

```
$('#myScrollspy').on('activate.bs.scrollspy', function () {
  // do something…
})
```

# Togglable tabs tab.js

## Example tabs

Add quick, dynamic tab functionality to transition through panes of local content, even via dropdown menus. **Nested tabs are not supported.**

- [Home](https://v3.bootcss.com/javascript/#home)
- [Profile](https://v3.bootcss.com/javascript/#profile)
- [Dropdown ](https://v3.bootcss.com/javascript/#)

Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.

#### Extends tabbed navigation

This plugin extends the [tabbed navigation component](https://v3.bootcss.com/components/#nav-tabs) to add tabbable areas.

## Usage

Enable tabbable tabs via JavaScript (each tab needs to be activated individually):

```
$('#myTabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})
```

You can activate individual tabs in several ways:

```
$('#myTabs a[href="#profile"]').tab('show') // Select tab by name
$('#myTabs a:first').tab('show') // Select first tab
$('#myTabs a:last').tab('show') // Select last tab
$('#myTabs li:eq(2) a').tab('show') // Select third tab (0-indexed)
```

### Markup

You can activate a tab or pill navigation without writing any JavaScript by simply specifying `data-toggle="tab"` or `data-toggle="pill"` on an element. Adding the `nav` and `nav-tabs` classes to the tab `ul` will apply the Bootstrap [tab styling](https://v3.bootcss.com/components/#nav-tabs), while adding the `nav` and `nav-pills` classes will apply [pill styling](https://v3.bootcss.com/components/#nav-pills).

```
<div>

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home">...</div>
    <div role="tabpanel" class="tab-pane" id="profile">...</div>
    <div role="tabpanel" class="tab-pane" id="messages">...</div>
    <div role="tabpanel" class="tab-pane" id="settings">...</div>
  </div>

</div>
```

### Fade effect

To make tabs fade in, add `.fade` to each `.tab-pane`. The first tab pane must also have `.in` to make the initial content visible.

```
<div class="tab-content">
  <div role="tabpanel" class="tab-pane fade in active" id="home">...</div>
  <div role="tabpanel" class="tab-pane fade" id="profile">...</div>
  <div role="tabpanel" class="tab-pane fade" id="messages">...</div>
  <div role="tabpanel" class="tab-pane fade" id="settings">...</div>
</div>
```

### Methods

#### `$().tab`

Activates a tab element and content container. Tab should have either a `data-target` or an `href` targeting a container node in the DOM. In the above examples, the tabs are the `<a>`s with `data-toggle="tab"` attributes.

#### `.tab('show')`

Selects the given tab and shows its associated content. Any other tab that was previously selected becomes unselected and its associated content is hidden. **Returns to the caller before the tab pane has actually been shown** (i.e. before the `shown.bs.tab` event occurs).

```
$('#someTab').tab('show')
```

### Events

When showing a new tab, the events fire in the following order:

1. `hide.bs.tab` (on the current active tab)
2. `show.bs.tab` (on the to-be-shown tab)
3. `hidden.bs.tab` (on the previous active tab, the same one as for the `hide.bs.tab` event)
4. `shown.bs.tab` (on the newly-active just-shown tab, the same one as for the `show.bs.tab` event)

If no tab was already active, then the `hide.bs.tab` and `hidden.bs.tab` events will not be fired.

| Event Type    | Description                                                  |
| :------------ | :----------------------------------------------------------- |
| show.bs.tab   | This event fires on tab show, but before the new tab has been shown. Use `event.target` and `event.relatedTarget` to target the active tab and the previous active tab (if available) respectively. |
| shown.bs.tab  | This event fires on tab show after a tab has been shown. Use `event.target` and `event.relatedTarget` to target the active tab and the previous active tab (if available) respectively. |
| hide.bs.tab   | This event fires when a new tab is to be shown (and thus the previous active tab is to be hidden). Use `event.target` and `event.relatedTarget` to target the current active tab and the new soon-to-be-active tab, respectively. |
| hidden.bs.tab | This event fires after a new tab is shown (and thus the previous active tab is hidden). Use `event.target` and `event.relatedTarget` to target the previous active tab and the new active tab, respectively. |

```
$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  e.target // newly activated tab
  e.relatedTarget // previous active tab
})
```

# Tooltips tooltip.js

Inspired by the excellent jQuery.tipsy plugin written by Jason Frame; Tooltips are an updated version, which don't rely on images, use CSS3 for animations, and data-attributes for local title storage.

Tooltips with zero-length titles are never displayed.

## Examples

Hover over the links below to see tooltips:

Tight pants next level keffiyeh [you probably](https://v3.bootcss.com/javascript/#) haven't heard of them. Photo booth beard raw denim letterpress vegan messenger bag stumptown. Farm-to-table seitan, mcsweeney's fixie sustainable quinoa 8-bit american apparel [have a](https://v3.bootcss.com/javascript/#) terry richardson vinyl chambray. Beard stumptown, cardigans banh mi lomo thundercats. Tofu biodiesel williamsburg marfa, four loko mcsweeney's cleanse vegan chambray. A really ironic artisan [whatever keytar](https://v3.bootcss.com/javascript/#), scenester farm-to-table banksy Austin [twitter handle](https://v3.bootcss.com/javascript/#) freegan cred raw denim single-origin coffee viral.

### Static tooltip

Four options are available: top, right, bottom, and left aligned.

Tooltip on the left

 

Tooltip on the top

 

Tooltip on the bottom

 

Tooltip on the right

### Four directions

Tooltip on left Tooltip on top Tooltip on bottom Tooltip on right

```
<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="left" title="Tooltip on left">Tooltip on left</button>

<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="Tooltip on top">Tooltip on top</button>

<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="Tooltip on bottom">Tooltip on bottom</button>

<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="Tooltip on right">Tooltip on right</button>
```

#### Opt-in functionality

For performance reasons, the Tooltip and Popover data-apis are opt-in, meaning **you must initialize them yourself**.

One way to initialize all tooltips on a page would be to select them by their `data-toggle` attribute:

```
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
```

## Usage

The tooltip plugin generates content and markup on demand, and by default places tooltips after their trigger element.

Trigger the tooltip via JavaScript:

```
$('#example').tooltip(options)
```

### Markup

The required markup for a tooltip is only a `data` attribute and `title` on the HTML element you wish to have a tooltip. The generated markup of a tooltip is rather simple, though it does require a position (by default, set to `top` by the plugin).

```
<!-- HTML to write -->
<a href="#" data-toggle="tooltip" title="Some tooltip text!">Hover over me</a>

<!-- Generated markup by the plugin -->
<div class="tooltip top" role="tooltip">
  <div class="tooltip-arrow"></div>
  <div class="tooltip-inner">
    Some tooltip text!
  </div>
</div>
```

#### Multiple-line links

Sometimes you want to add a tooltip to a hyperlink that wraps multiple lines. The default behavior of the tooltip plugin is to center it horizontally and vertically. Add `white-space: nowrap;` to your anchors to avoid this.

#### Tooltips in button groups, input groups, and tables require special setting

When using tooltips on elements within a `.btn-group` or an `.input-group`, or on table-related elements (`<td>`, `<th>`, `<tr>`, `<thead>`, `<tbody>`, `<tfoot>`), you'll have to specify the option `container: 'body'` (documented below) to avoid unwanted side effects (such as the element growing wider and/or losing its rounded corners when the tooltip is triggered).

#### Don't try to show tooltips on hidden elements

Invoking `$(...).tooltip('show')` when the target element is `display: none;` will cause the tooltip to be incorrectly positioned.

#### Accessible tooltips for keyboard and assistive technology users

For users navigating with a keyboard, and in particular users of assistive technologies, you should only add tooltips to keyboard-focusable elements such as links, form controls, or any arbitrary element with a `tabindex="0"` attribute.

#### Tooltips on disabled elements require wrapper elements

To add a tooltip to a `disabled` or `.disabled` element, put the element inside of a `<div>` and apply the tooltip to that `<div>` instead.

### Options

Options can be passed via data attributes or JavaScript. For data attributes, append the option name to `data-`, as in `data-animation=""`.

Note that for security reasons the `sanitize`, `sanitizeFn` and `whiteList` options cannot be supplied using data attributes.

| Name       | Type                         | Default                                                      | Description                                                  |
| :--------- | :--------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| animation  | boolean                      | true                                                         | Apply a CSS fade transition to the tooltip                   |
| container  | string \| false              | false                                                        | Appends the tooltip to a specific element. Example: `container: 'body'`. This option is particularly useful in that it allows you to position the tooltip in the flow of the document near the triggering element - which will prevent the tooltip from floating away from the triggering element during a window resize. |
| delay      | number \| object             | 0                                                            | Delay showing and hiding the tooltip (ms) - does not apply to manual trigger typeIf a number is supplied, delay is applied to both hide/showObject structure is: `delay: { "show": 500, "hide": 100 }` |
| html       | boolean                      | false                                                        | Insert HTML into the tooltip. If false, jQuery's `text` method will be used to insert content into the DOM. Use text if you're worried about XSS attacks. |
| placement  | string \| function           | 'top'                                                        | How to position the tooltip - top \| bottom \| left \| right \| auto. When "auto" is specified, it will dynamically reorient the tooltip. For example, if placement is "auto left", the tooltip will display to the left when possible, otherwise it will display right.When a function is used to determine the placement, it is called with the tooltip DOM node as its first argument and the triggering element DOM node as its second. The `this` context is set to the tooltip instance. |
| selector   | string                       | false                                                        | If a selector is provided, tooltip objects will be delegated to the specified targets. In practice, this is used to also apply tooltips to dynamically added DOM elements (`jQuery.on` support). See [this](https://github.com/twbs/bootstrap/issues/4215) and [an informative example](http://jsbin.com/zopod/1/edit). |
| template   | string                       | `'<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'` | Base HTML to use when creating the tooltip.The tooltip's `title` will be injected into the `.tooltip-inner`.`.tooltip-arrow` will become the tooltip's arrow.The outermost wrapper element should have the `.tooltip` class. |
| title      | string \| function           | ''                                                           | Default title value if `title` attribute isn't present.If a function is given, it will be called with its `this` reference set to the element that the tooltip is attached to. |
| trigger    | string                       | 'hover focus'                                                | How tooltip is triggered - click \| hover \| focus \| manual. You may pass multiple triggers; separate them with a space. `manual` cannot be combined with any other trigger. |
| viewport   | string \| object \| function | { selector: 'body', padding: 0 }                             | Keeps the tooltip within the bounds of this element. Example: `viewport: '#viewport'` or `{ "selector": "#viewport", "padding": 0 }`If a function is given, it is called with the triggering element DOM node as its only argument. The `this` context is set to the tooltip instance. |
| sanitize   | boolean                      | true                                                         | Enable or disable the sanitization. If activated `'template'`, `'content'` and `'title'` options will be sanitized. |
| whiteList  | object                       | [Default value](https://v3.bootcss.com/javascript/#js-sanitizer) | Object which contains allowed attributes and tags            |
| sanitizeFn | null \| function             | null                                                         | Here you can supply your own sanitize function. This can be useful if you prefer to use a dedicated library to perform sanitization. |

#### Data attributes for individual tooltips

Options for individual tooltips can alternatively be specified through the use of data attributes, as explained above.

### Methods

#### `$().tooltip(options)`

Attaches a tooltip handler to an element collection.

#### `.tooltip('show')`

Reveals an element's tooltip. **Returns to the caller before the tooltip has actually been shown** (i.e. before the `shown.bs.tooltip` event occurs). This is considered a "manual" triggering of the tooltip. Tooltips with zero-length titles are never displayed.

```
$('#element').tooltip('show')
```

#### `.tooltip('hide')`

Hides an element's tooltip. **Returns to the caller before the tooltip has actually been hidden** (i.e. before the `hidden.bs.tooltip` event occurs). This is considered a "manual" triggering of the tooltip.

```
$('#element').tooltip('hide')
```

#### `.tooltip('toggle')`

Toggles an element's tooltip. **Returns to the caller before the tooltip has actually been shown or hidden** (i.e. before the `shown.bs.tooltip` or `hidden.bs.tooltip` event occurs). This is considered a "manual" triggering of the tooltip.

```
$('#element').tooltip('toggle')
```

#### `.tooltip('destroy')`

Hides and destroys an element's tooltip. Tooltips that use delegation (which are created using [the `selector` option](https://v3.bootcss.com/javascript/#tooltips-options)) cannot be individually destroyed on descendant trigger elements.

```
$('#element').tooltip('destroy')
```

### Events

| Event Type          | Description                                                  |
| :------------------ | :----------------------------------------------------------- |
| show.bs.tooltip     | This event fires immediately when the `show` instance method is called. |
| shown.bs.tooltip    | This event is fired when the tooltip has been made visible to the user (will wait for CSS transitions to complete). |
| hide.bs.tooltip     | This event is fired immediately when the `hide` instance method has been called. |
| hidden.bs.tooltip   | This event is fired when the tooltip has finished being hidden from the user (will wait for CSS transitions to complete). |
| inserted.bs.tooltip | This event is fired after the `show.bs.tooltip` event when the tooltip template has been added to the DOM. |

```
$('#myTooltip').on('hidden.bs.tooltip', function () {
  // do something…
})
```

# 弹出框 popover.js

为任意元素添加一小块浮层，就像 iPad 上一样，用于存放非主要信息。

弹出框的标题和内容的长度都是零的话将永远不会被显示出来。

#### 插件依赖

弹出框依赖 [工具提示插件](https://v3.bootcss.com/javascript/#tooltips) ，因此，如果你定制了 Bootstrap，一定要注意将依赖的插件编译进去。

#### 初始化

由于性能的原因，工具提示和弹出框的 data 编程接口（data api）是必须要**手动初始化的**。

在一个页面上一次性初始化所有弹出框的方式是通过 `data-toggle` 属性选中他们：

```
$(function () {
  $('[data-toggle="popover"]').popover()
})
```

#### Popovers in button groups, input groups, and tables require special setting

When using popovers on elements within a `.btn-group` or an `.input-group`, or on table-related elements (`<td>`, `<th>`, `<tr>`, `<thead>`, `<tbody>`, `<tfoot>`), you'll have to specify the option `container: 'body'` (documented below) to avoid unwanted side effects (such as the element growing wider and/or losing its rounded corners when the popover is triggered).

#### Don't try to show popovers on hidden elements

Invoking `$(...).popover('show')` when the target element is `display: none;` will cause the popover to be incorrectly positioned.

#### Popovers on disabled elements require wrapper elements

To add a popover to a `disabled` or `.disabled` element, put the element inside of a `<div>` and apply the popover to that `<div>` instead.

#### Multiple-line links

Sometimes you want to add a popover to a hyperlink that wraps multiple lines. The default behavior of the popover plugin is to center it horizontally and vertically. Add `white-space: nowrap;` to your anchors to avoid this.

## 实例

### 静态弹出框

4个可能的弹出方向：顶部、右侧、底部和左侧。

### Popover 顶部

Sed posuere consectetur est at lobortis. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.

### Popover 右侧

Sed posuere consectetur est at lobortis. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.

### Popover 顶部

Sed posuere consectetur est at lobortis. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.

### Popover 左侧

Sed posuere consectetur est at lobortis. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.

### 实例演示

点我弹出/隐藏弹出框

```
<button type="button" class="btn btn-lg btn-danger" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">点我弹出/隐藏弹出框</button>
```

#### 4个弹出方向

Popover on right Popover on top Popover on bottom Popover on left

```
<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="left" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
  Popover on 左侧
</button>

<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="top" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
  Popover on 顶部
</button>

<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="bottom" data-content="Vivamus
sagittis lacus vel augue laoreet rutrum faucibus.">
  Popover on 底部
</button>

<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="right" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
  Popover on 右侧
</button>
```

#### 点击并让弹出框消失

通过使用 `focus` 触发器可以在用户点击弹出框是让其消失。

#### 实现“点击并让弹出框消失”的效果需要一些额外的代码

为了更好的跨浏览器和跨平台效果，你必须使用 `<a>` 签，*不能* 使用 `<button>` 标签，并且，还必须包含 `role="button"` 和 [`tabindex`](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/tabindex) 属性。

可消失的弹出框

```
<a tabindex="0" class="btn btn-lg btn-danger" role="button" data-toggle="popover" data-trigger="focus" title="Dismissible popover" data-content="And here's some amazing content. It's very engaging. Right?">可消失的弹出框</a>
```

## 用法

通过 JavaScript 代码启动弹出框：

```
$('#example').popover(options)
```

### 参数

可以通过 data 属性或 JavaScript 传递参数。对于 data 属性，将参数名附着到 `data-` 后面，例如 `data-animation=""`。

Note that for security reasons the `sanitize`, `sanitizeFn` and `whiteList` options cannot be supplied using data attributes.

| 名称       | 类型                         | 默认值                                                       | 描述                                                         |
| :--------- | :--------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| animation  | boolean                      | true                                                         | 为弹出框赋予淡出的 CSS 动画效果。                            |
| container  | string \| false              | false                                                        | Appends the popover to a specific element. Example: `container: 'body'`. This option is particularly useful in that it allows you to position the popover in the flow of the document near the triggering element - which will prevent the popover from floating away from the triggering element during a window resize. |
| content    | string \| function           | ''                                                           | Default content value if `data-content` attribute isn't present.If a function is given, it will be called with its `this` reference set to the element that the popover is attached to. |
| delay      | number \| object             | 0                                                            | Delay showing and hiding the popover (ms) - does not apply to manual trigger typeIf a number is supplied, delay is applied to both hide/showObject structure is: `delay: { "show": 500, "hide": 100 }` |
| html       | boolean                      | false                                                        | Insert HTML into the popover. If false, jQuery's `text` method will be used to insert content into the DOM. Use text if you're worried about XSS attacks. |
| placement  | string \| function           | 'right'                                                      | How to position the popover - top \| bottom \| left \| right \| auto. When "auto" is specified, it will dynamically reorient the popover. For example, if placement is "auto left", the popover will display to the left when possible, otherwise it will display right.When a function is used to determine the placement, it is called with the popover DOM node as its first argument and the triggering element DOM node as its second. The `this` context is set to the popover instance. |
| selector   | string                       | false                                                        | If a selector is provided, popover objects will be delegated to the specified targets. In practice, this is used to enable dynamic HTML content to have popovers added. See [this](https://github.com/twbs/bootstrap/issues/4215) and [an informative example](http://jsbin.com/zopod/1/edit). |
| template   | string                       | `'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'` | Base HTML to use when creating the popover.The popover's `title` will be injected into the `.popover-title`.The popover's `content` will be injected into the `.popover-content`.`.arrow` will become the popover's arrow.The outermost wrapper element should have the `.popover` class. |
| title      | string \| function           | ''                                                           | Default title value if `title` attribute isn't present.If a function is given, it will be called with its `this` reference set to the element that the popover is attached to. |
| trigger    | string                       | 'click'                                                      | How popover is triggered - click \| hover \| focus \| manual. You may pass multiple triggers; separate them with a space. `manual` cannot be combined with any other trigger. |
| viewport   | string \| object \| function | { selector: 'body', padding: 0 }                             | Keeps the popover within the bounds of this element. Example: `viewport: '#viewport'` or `{ "selector": "#viewport", "padding": 0 }`If a function is given, it is called with the triggering element DOM node as its only argument. The `this` context is set to the popover instance. |
| sanitize   | boolean                      | true                                                         | Enable or disable the sanitization. If activated `'template'`, `'content'` and `'title'` options will be sanitized. |
| whiteList  | object                       | [Default value](https://v3.bootcss.com/javascript/#js-sanitizer) | Object which contains allowed attributes and tags            |
| sanitizeFn | null \| function             | null                                                         | Here you can supply your own sanitize function. This can be useful if you prefer to use a dedicated library to perform sanitization. |

#### Data attributes for individual popovers

Options for individual popovers can alternatively be specified through the use of data attributes, as explained above.

### Methods

#### `$().popover(options)`

Initializes popovers for an element collection.

#### `.popover('show')`

Reveals an element's popover. **Returns to the caller before the popover has actually been shown** (i.e. before the `shown.bs.popover` event occurs). This is considered a "manual" triggering of the popover. Popovers whose both title and content are zero-length are never displayed.

```
$('#element').popover('show')
```

#### `.popover('hide')`

Hides an element's popover. **Returns to the caller before the popover has actually been hidden** (i.e. before the `hidden.bs.popover` event occurs). This is considered a "manual" triggering of the popover.

```
$('#element').popover('hide')
```

#### `.popover('toggle')`

Toggles an element's popover. **Returns to the caller before the popover has actually been shown or hidden** (i.e. before the `shown.bs.popover` or `hidden.bs.popover` event occurs). This is considered a "manual" triggering of the popover.

```
$('#element').popover('toggle')
```

#### `.popover('destroy')`

Hides and destroys an element's popover. Popovers that use delegation (which are created using [the `selector` option](https://v3.bootcss.com/javascript/#popovers-options)) cannot be individually destroyed on descendant trigger elements.

```
$('#element').popover('destroy')
```

### Events

| Event Type          | Description                                                  |
| :------------------ | :----------------------------------------------------------- |
| show.bs.popover     | This event fires immediately when the `show` instance method is called. |
| shown.bs.popover    | This event is fired when the popover has been made visible to the user (will wait for CSS transitions to complete). |
| hide.bs.popover     | This event is fired immediately when the `hide` instance method has been called. |
| hidden.bs.popover   | This event is fired when the popover has finished being hidden from the user (will wait for CSS transitions to complete). |
| inserted.bs.popover | This event is fired after the `show.bs.popover` event when the popover template has been added to the DOM. |

```
$('#myPopover').on('hidden.bs.popover', function () {
  // do something…
})
```

# 警告信息 alert.js

## 实例

通过此插件可以为警告信息添加点击并消失的功能。

当使用 `.close` 按钮时，它必须是 `.alert-dismissible` 的第一个子元素，并且在它之前不能有任何文本内容。

×**Holy guacamole!** Best check yo self, you're not looking too good.

×

#### Oh snap! You got an error!

Change this and that and try again. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.

Take this action Or do this

## 用法

为关闭按钮添加 `data-dismiss="alert"` 属性就可以使其自动为警告框赋予关闭功能。关闭警告框也就是将其从 DOM 中删除。

```
<button type="button" class="close" data-dismiss="alert" aria-label="Close">
  <span aria-hidden="true">&times;</span>
</button>
```

为了让警告框在关闭时表现出动画效果，请确保为其添加了 `.fade` 和 `.in` 类。

### 方法

#### `$().alert()`

让警告框监听具有 `data-dismiss="alert"` 属性的后裔元素的点击（click）事件。（如果是通过 data 属性进行的初始化则无需使用）

#### `$().alert('close')`

关闭警告框并从 DOM 中将其删除。如果警告框被赋予了 `.fade` 和 `.in` 类，那么，警告框在淡出之后才会被删除。

### 事件

Bootstrap 的警告框插件对外暴露了一些可以被监听的事件。

| 事件类型        | 描述                                                         |
| :-------------- | :----------------------------------------------------------- |
| close.bs.alert  | 当 `close` 方法被调用后立即触发此事件。                      |
| closed.bs.alert | 当警告框被关闭后（也即 CSS 过渡效果完毕之后）立即触发此事件。 |

```
$('#myAlert').on('closed.bs.alert', function () {
  // do something…
})
```

# 按钮 button.js

按钮的功能很丰富。通过控制按钮的状态或创建一组按钮并形成一些新的组件，例如工具条。

#### 跨浏览器兼容性

[在页面多次加载之间，Firefox 仍然保持表单控件的状态（禁用状态和选择状态）](https://github.com/twbs/bootstrap/issues/793)。一个解决办法是设置 `autocomplete="off"`。参见 [Mozilla bug #654072](https://bugzilla.mozilla.org/show_bug.cgi?id=654072)。

## 状态

通过添加 `data-loading-text="Loading..."` 可以为按钮设置正在加载的状态。

**从 v3.3.5 版本开始，此特性不再建议使用，并且已经在 v4 版本中删除了。**

#### Use whichever state you like!

For the sake of this demonstration, we are using `data-loading-text` and `$().button('loading')`, but that's not the only state you can use. [See more on this below in the `$().button(string)` documentation](https://v3.bootcss.com/javascript/#buttons-methods).

Loading state

```
<button type="button" id="myButton" data-loading-text="Loading..." class="btn btn-primary">
  Loading state
</button>

<script>
  $('#myButton').on('click', function () {
    var $btn = $(this).button('loading')
    // business logic...
    $btn.button('reset')
  })
</script>
```

## Single toggle

Add `data-toggle="button"` to activate toggling on a single button.

#### Pre-toggled buttons need `.active` and `aria-pressed="true"`

For pre-toggled buttons, you must add the `.active` class and the `aria-pressed="true"` attribute to the `button` yourself.

Single toggle

```
<button type="button" class="btn btn-primary" data-toggle="button" aria-pressed="false">
  Single toggle
</button>
```

## Checkbox / Radio

Add `data-toggle="buttons"` to a `.btn-group` containing checkbox or radio inputs to enable toggling in their respective styles.

#### Preselected options need `.active`

For preselected options, you must add the `.active` class to the input's `label` yourself.

#### Visual checked state only updated on click

If the checked state of a checkbox button is updated without firing a `click` event on the button (e.g. via `<input type="reset">` or via setting the `checked` property of the input), you will need to toggle the `.active` class on the input's `label` yourself.

Checkbox 1 (pre-checked)Checkbox 2Checkbox 3

```
<div class="btn-group" data-toggle="buttons">
  <label class="btn btn-primary active">
    <input type="checkbox" checked> Checkbox 1 (pre-checked)
  </label>
  <label class="btn btn-primary">
    <input type="checkbox"> Checkbox 2
  </label>
  <label class="btn btn-primary">
    <input type="checkbox"> Checkbox 3
  </label>
</div>
```

Radio 1 (preselected)Radio 2Radio 3

```
<div class="btn-group" data-toggle="buttons">
  <label class="btn btn-primary active">
    <input type="radio" name="options" id="option1" checked> Radio 1 (preselected)
  </label>
  <label class="btn btn-primary">
    <input type="radio" name="options" id="option2"> Radio 2
  </label>
  <label class="btn btn-primary">
    <input type="radio" name="options" id="option3"> Radio 3
  </label>
</div>
```

## 方法

#### `$().button('toggle')`

Toggles push state. Gives the button the appearance that it has been activated.

#### `$().button('reset')`

重置按钮状态 - 将按钮上的文本还原回原始的内容。**此为异步方法，此方法在内容被重置完成之前即返回。**

#### `$().button(string)`

Swaps text to any data defined text state.

```
<button type="button" id="myStateButton" data-complete-text="finished!" class="btn btn-primary">
  ...
</button>

<script>
  $('#myStateButton').on('click', function () {
    $(this).button('complete') // button text will be "finished!"
  })
</script>
```

# Collapse collapse.js

Flexible plugin that utilizes a handful of classes for easy toggle behavior.

#### Plugin dependency

Collapse requires the [transitions plugin](https://v3.bootcss.com/javascript/#transitions) to be included in your version of Bootstrap.

## Example

Click the buttons below to show and hide another element via class changes:

- `.collapse` hides content
- `.collapsing` is applied during transitions
- `.collapse.in` shows content

You can use a link with the `href` attribute, or a button with the `data-target` attribute. In both cases, the `data-toggle="collapse"` is required.

[Link with href](https://v3.bootcss.com/javascript/#collapseExample) Button with data-target

```
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
  Link with href
</a>
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
  Button with data-target
</button>
<div class="collapse" id="collapseExample">
  <div class="well">
    ...
  </div>
</div>
```

## Accordion example

Extend the default collapse behavior to create an accordion with the panel component.

#### [Collapsible Group Item #1](https://v3.bootcss.com/javascript/#collapseOne)

Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.

#### [Collapsible Group Item #2](https://v3.bootcss.com/javascript/#collapseTwo)

#### [Collapsible Group Item #3](https://v3.bootcss.com/javascript/#collapseThree)

```
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          Collapsible Group Item #1
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          Collapsible Group Item #2
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          Collapsible Group Item #3
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div>
</div>
```

It's also possible to swap out `.panel-body`s with `.list-group`s.

#### [Collapsible list group](https://v3.bootcss.com/javascript/#collapseListGroup1)

#### Make expand/collapse controls accessible

Be sure to add `aria-expanded` to the control element. This attribute explicitly defines the current state of the collapsible element to screen readers and similar assistive technologies. If the collapsible element is closed by default, it should have a value of `aria-expanded="false"`. If you've set the collapsible element to be open by default using the `in` class, set `aria-expanded="true"` on the control instead. The plugin will automatically toggle this attribute based on whether or not the collapsible element has been opened or closed.

Additionally, if your control element is targeting a single collapsible element – i.e. the `data-target` attribute is pointing to an `id` selector – you may add an additional `aria-controls` attribute to the control element, containing the `id` of the collapsible element. Modern screen readers and similar assistive technologies make use of this attribute to provide users with additional shortcuts to navigate directly to the collapsible element itself.

## Usage

The collapse plugin utilizes a few classes to handle the heavy lifting:

- `.collapse` hides the content
- `.collapse.in` shows the content
- `.collapsing` is added when the transition starts, and removed when it finishes

These classes can be found in `component-animations.less`.

### Via data attributes

Just add `data-toggle="collapse"` and a `data-target` to the element to automatically assign control of a collapsible element. The `data-target` attribute accepts a CSS selector to apply the collapse to. Be sure to add the class `collapse` to the collapsible element. If you'd like it to default open, add the additional class `in`.

To add accordion-like group management to a collapsible control, add the data attribute `data-parent="#selector"`. Refer to the demo to see this in action.

### Via JavaScript

Enable manually with:

```
$('.collapse').collapse()
```

### Options

Options can be passed via data attributes or JavaScript. For data attributes, append the option name to `data-`, as in `data-parent=""`.

| Name   | type     | default | description                                                  |
| :----- | :------- | :------ | :----------------------------------------------------------- |
| parent | selector | false   | If a selector is provided, then all collapsible elements under the specified parent will be closed when this collapsible item is shown. (similar to traditional accordion behavior - this is dependent on the `panel` class) |
| toggle | boolean  | true    | Toggles the collapsible element on invocation                |

### Methods

#### `.collapse(options)`

Activates your content as a collapsible element. Accepts an optional options `object`.

```
$('#myCollapsible').collapse({
  toggle: false
})
```

#### `.collapse('toggle')`

Toggles a collapsible element to shown or hidden. **Returns to the caller before the collapsible element has actually been shown or hidden** (i.e. before the `shown.bs.collapse` or `hidden.bs.collapse` event occurs).

#### `.collapse('show')`

Shows a collapsible element. **Returns to the caller before the collapsible element has actually been shown** (i.e. before the `shown.bs.collapse` event occurs).

#### `.collapse('hide')`

Hides a collapsible element. **Returns to the caller before the collapsible element has actually been hidden** (i.e. before the `hidden.bs.collapse` event occurs).

### Events

Bootstrap's collapse class exposes a few events for hooking into collapse functionality.

| Event Type         | Description                                                  |
| :----------------- | :----------------------------------------------------------- |
| show.bs.collapse   | This event fires immediately when the `show` instance method is called. |
| shown.bs.collapse  | This event is fired when a collapse element has been made visible to the user (will wait for CSS transitions to complete). |
| hide.bs.collapse   | This event is fired immediately when the `hide` method has been called. |
| hidden.bs.collapse | This event is fired when a collapse element has been hidden from the user (will wait for CSS transitions to complete). |

```
$('#myCollapsible').on('hidden.bs.collapse', function () {
  // do something…
})
```

# Carousel carousel.js

A slideshow component for cycling through elements, like a carousel. **Nested carousels are not supported.**

## Examples

1. 
2.  

3. 
4.  

5. 

![First slide]()

[Previous](https://v3.bootcss.com/javascript/#carousel-example-generic)[Next](https://v3.bootcss.com/javascript/#carousel-example-generic)

```
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="..." alt="...">
      <div class="carousel-caption">
        ...
      </div>
    </div>
    <div class="item">
      <img src="..." alt="...">
      <div class="carousel-caption">
        ...
      </div>
    </div>
    ...
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
```

#### Accessibility issue

The carousel component is generally not compliant with accessibility standards. If you need to be compliant, please consider other options for presenting your content.

#### Transition animations not supported in Internet Explorer 8 & 9

Bootstrap exclusively uses CSS3 for its animations, but Internet Explorer 8 & 9 don't support the necessary CSS properties. Thus, there are no slide transition animations when using these browsers. We have intentionally decided not to include jQuery-based fallbacks for the transitions.

#### Initial active element required

The `.active` class needs to be added to one of the slides. Otherwise, the carousel will not be visible.

#### Glyphicon icons not necessary

The `.glyphicon .glyphicon-chevron-left` and `.glyphicon .glyphicon-chevron-right` classes are not necessarily needed for the controls. Bootstrap provides `.icon-prev` and `.icon-next` as plain unicode alternatives.

### Optional captions

Add captions to your slides easily with the `.carousel-caption` element within any `.item`. Place just about any optional HTML within there and it will be automatically aligned and formatted.

1. 
2.  

3. 
4.  

5. 

![First slide image]()

### First slide label

Nulla vitae elit libero, a pharetra augue mollis interdum.

[Previous](https://v3.bootcss.com/javascript/#carousel-example-captions)[Next](https://v3.bootcss.com/javascript/#carousel-example-captions)

```
<div class="item">
  <img src="..." alt="...">
  <div class="carousel-caption">
    <h3>...</h3>
    <p>...</p>
  </div>
</div>
```

## Usage

### Multiple carousels

Carousels require the use of an `id` on the outermost container (the `.carousel`) for carousel controls to function properly. When adding multiple carousels, or when changing a carousel's `id`, be sure to update the relevant controls.

### Via data attributes

Use data attributes to easily control the position of the carousel. `data-slide` accepts the keywords `prev` or `next`, which alters the slide position relative to its current position. Alternatively, use `data-slide-to` to pass a raw slide index to the carousel `data-slide-to="2"`, which shifts the slide position to a particular index beginning with `0`.

The `data-ride="carousel"` attribute is used to mark a carousel as animating starting at page load. **It cannot be used in combination with (redundant and unnecessary) explicit JavaScript initialization of the same carousel.**

### Via JavaScript

Call carousel manually with:

```
$('.carousel').carousel()
```

### Options

Options can be passed via data attributes or JavaScript. For data attributes, append the option name to `data-`, as in `data-interval=""`.

| Name     | type           | default | description                                                  |
| :------- | :------------- | :------ | :----------------------------------------------------------- |
| interval | number         | 5000    | The amount of time to delay between automatically cycling an item. If false, carousel will not automatically cycle. |
| pause    | string \| null | "hover" | If set to `"hover"`, pauses the cycling of the carousel on `mouseenter` and resumes the cycling of the carousel on `mouseleave`. If set to `null`, hovering over the carousel won't pause it. |
| wrap     | boolean        | true    | Whether the carousel should cycle continuously or have hard stops. |
| keyboard | boolean        | true    | Whether the carousel should react to keyboard events.        |

### Methods

#### `.carousel(options)`

Initializes the carousel with an optional options `object` and starts cycling through items.

```
$('.carousel').carousel({
  interval: 2000
})
```

#### `.carousel('cycle')`

Cycles through the carousel items from left to right.

#### `.carousel('pause')`

Stops the carousel from cycling through items.

#### `.carousel(number)`

Cycles the carousel to a particular frame (0 based, similar to an array).

#### `.carousel('prev')`

Cycles to the previous item.

#### `.carousel('next')`

Cycles to the next item.

### Events

Bootstrap's carousel class exposes two events for hooking into carousel functionality.

Both events have the following additional properties:

- `direction`: The direction in which the carousel is sliding (either `"left"` or `"right"`).
- `relatedTarget`: The DOM element that is being slid into place as the active item.

All carousel events are fired at the carousel itself (i.e. at the `<div class="carousel">`).

| Event Type        | Description                                                  |
| :---------------- | :----------------------------------------------------------- |
| slide.bs.carousel | This event fires immediately when the `slide` instance method is invoked. |
| slid.bs.carousel  | This event is fired when the carousel has completed its slide transition. |

```
$('#myCarousel').on('slide.bs.carousel', function () {
  // do something…
})
```

# Affix affix.js

## Example

The affix plugin toggles `position: fixed;` on and off, emulating the effect found with [`position: sticky;`](https://developer.mozilla.org/en-US/docs/Web/CSS/position#Sticky_positioning). The subnavigation on the right is a live demo of the affix plugin.

------

## Usage

Use the affix plugin via data attributes or manually with your own JavaScript. **In both situations, you must provide CSS for the positioning and width of your affixed content.**

Note: Do not use the affix plugin on an element contained in a relatively positioned element, such as a pulled or pushed column, due to a [Safari rendering bug](https://github.com/twbs/bootstrap/issues/12126).

### Positioning via CSS

The affix plugin toggles between three classes, each representing a particular state: `.affix`, `.affix-top`, and `.affix-bottom`. You must provide the styles, with the exception of `position: fixed;` on `.affix`, for these classes yourself (independent of this plugin) to handle the actual positions.

Here's how the affix plugin works:

1. To start, the plugin adds `.affix-top` to indicate the element is in its top-most position. At this point no CSS positioning is required.
2. Scrolling past the element you want affixed should trigger the actual affixing. This is where `.affix` replaces `.affix-top` and sets `position: fixed;` (provided by Bootstrap's CSS).
3. If a bottom offset is defined, scrolling past it should replace `.affix` with `.affix-bottom`. Since offsets are optional, setting one requires you to set the appropriate CSS. In this case, add `position: absolute;` when necessary. The plugin uses the data attribute or JavaScript option to determine where to position the element from there.

Follow the above steps to set your CSS for either of the usage options below.

### Via data attributes

To easily add affix behavior to any element, just add `data-spy="affix"` to the element you want to spy on. Use offsets to define when to toggle the pinning of an element.

```
<div data-spy="affix" data-offset-top="60" data-offset-bottom="200">
  ...
</div>
```

### Via JavaScript

Call the affix plugin via JavaScript:

```
$('#myAffix').affix({
  offset: {
    top: 100,
    bottom: function () {
      return (this.bottom = $('.footer').outerHeight(true))
    }
  }
})
```

### Options

Options can be passed via data attributes or JavaScript. For data attributes, append the option name to `data-`, as in `data-offset-top="200"`.

| Name   | type                               | default             | description                                                  |
| :----- | :--------------------------------- | :------------------ | :----------------------------------------------------------- |
| offset | number \| function \| object       | 10                  | Pixels to offset from screen when calculating position of scroll. If a single number is provided, the offset will be applied in both top and bottom directions. To provide a unique, bottom and top offset just provide an object `offset: { top: 10 }` or `offset: { top: 10, bottom: 5 }`. Use a function when you need to dynamically calculate an offset. |
| target | selector \| node \| jQuery element | the `window` object | Specifies the target element of the affix.                   |

### Methods

#### `.affix(options)`

Activates your content as affixed content. Accepts an optional options `object`.

```
$('#myAffix').affix({
  offset: 15
})
```

#### `.affix('checkPosition')`

Recalculates the state of the affix based on the dimensions, position, and scroll position of the relevant elements. The `.affix`, `.affix-top`, and `.affix-bottom` classes are added to or removed from the affixed content according to the new state. This method needs to be called whenever the dimensions of the affixed content or the target element are changed, to ensure correct positioning of the affixed content.

```
$('#myAffix').affix('checkPosition')
```

### Events

Bootstrap's affix plugin exposes a few events for hooking into affix functionality.

| Event Type              | Description                                                  |
| :---------------------- | :----------------------------------------------------------- |
| affix.bs.affix          | This event fires immediately before the element has been affixed. |
| affixed.bs.affix        | This event is fired after the element has been affixed.      |
| affix-top.bs.affix      | This event fires immediately before the element has been affixed-top. |
| affixed-top.bs.affix    | This event is fired after the element has been affixed-top.  |
| affix-bottom.bs.affix   | This event fires immediately before the element has been affixed-bottom. |
| affixed-bottom.bs.affix | This event is fired after the element has been affixed-bottom. |