package util {

import mx.core.UIComponent;
import mx.events.FlexEvent;

public class Compere {
    private var container:UIComponent;
    private var current:UIComponent

    public function Compere(container:UIComponent, current:UIComponent, introduceCurrent:Boolean=true) {
        this.container = container
        this.current = current

        if (introduceCurrent) reshowCurrent()
    }

    public function show(toCurrent:UIComponent):void {
        if (container.currentState == toCurrent.id) return

        // TODO will creation of this anon-function produce a memory leak?
        const onHidden:Function = function (e:FlexEvent):void {
            current.removeEventListener(FlexEvent.STATE_CHANGE_COMPLETE, onHidden)
            current = toCurrent

            container.currentState = toCurrent.id

            reshowCurrent()
        }

        current.addEventListener(FlexEvent.STATE_CHANGE_COMPLETE, onHidden)
        current.currentState = 'hidden'
    }

    public function reshowCurrent():void {
        current.currentState = 'hidden'
        container.callLater(function():void {
            current.currentState = 'normal'
        })
    }
}
}
